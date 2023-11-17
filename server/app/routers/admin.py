"""Collection of all API routings related to Admin Services.

date: 02/11/2023
"""
# ---- Standard
import logging
from enum import Enum
from typing import List, Optional
from datetime import date

# ---- Thirdparty
from fastapi import HTTPException, status, Depends
from fastapi.routing import APIRouter
from tortoise.exceptions import DoesNotExist

# ---- Locals
from routers.account import get_admin_user, get_super_admin_user
from internal.database import *
from internal.schema import *


class _AdminUserAction(str, Enum):
    BAN = "ban"
    UNBAN = "unban"


class _AdminArchiveAction(str, Enum):
    RECOVER = "recover"


class _AdminAppointmentFilter(str, Enum):
    ALL = "all"
    PENDING = "pending"
    APPROVED = "approved"
    TODAY = "today"


class AdminManager:
    def __init__(self, router: Optional[APIRouter] = None, log: Optional[logging.Logger] = None) -> None:
        self._log = log if log else logging.getLogger(__name__)
        self._routing = router if router else APIRouter()
        # ---- Set all routes
        self._routing.add_api_route(
            "/admin/",
            self.admin_get_stats,
            methods=["GET"],
            response_model=AdminStatsApi,
            description="Admin Index Page.",
        )
        self._routing.add_api_route(
            "/admin/appointment/",
            self.admin_get_appointments,
            methods=["GET"],
            response_model=List[AppointmentInfoApi],
            description="Returns all appointment data stored in the database.",
        )
        self._routing.add_api_route(
            "/admin/appointment/today",
            self.admin_get_appointment_today,
            methods=["GET"],
            response_model=List[AppointmentInfoApi],
            description="Returns todays appointment data stored in the database.",
        )
        self._routing.add_api_route(
            "/admin/appointment/{appointment_id}/update/",
            self.admin_update_appointment,
            methods=["POST"],
            response_model=AppointmentInfoApi,
            description="Updates the appointment status.",
        )
        self._routing.add_api_route(
            "/admin/user/",
            self.admin_get_user_list,
            methods=["GET"],
            response_model=List[UserProfileApi],
            description="Get list of user profile depending on filter.",
        )
        self._routing.add_api_route(
            "/admin/user/{user_id}/",
            self.admin_get_user,
            methods=["GET"],
            response_model=UserProfileApi,
            description="Get the user profile.",
        )
        self._routing.add_api_route(
            "/admin/user/{user_id}/",
            self.admin_delete_user,
            methods=["DELETE"],
            description="Delete a user",
        )
        self._routing.add_api_route(
            "/admin/user/banned/all/",
            self.admin_get_banned_users,
            methods=["GET"],
            response_model=List[UserProfileApi],
            description="Get all banned user",
        )
        self._routing.add_api_route(
            "/admin/user/{user_id}/{action}/",
            self.admin_user_action,
            methods=["POST"],
            description='Possibe action ["ban", "unban"]',
        )
        self._routing.add_api_route(
            "/admin/archive/",
            self.admin_archive_get_all,
            methods=["GET"],
            description="Get the all archive data",
            response_model=List[ArchiveUserSchema],
        )
        self._routing.add_api_route(
            "/admin/archive/recover/",
            self.admin_recover_user,
            methods=["POST"],
            description="Do action on archive data",
            response_model=UserProfileApi,
        )
        self._routing.add_api_route(
            "/admin/archive/query/",
            self.admin_archive_get,
            methods=["GET"],
            description="Get an archive data",
            response_model=ArchiveUserSchema,
        )
        self._routing.add_api_route(
            "/admin/thread/banned/",
            self.get_banned_thread_list,
            methods=["GET"],
            response_model=List[BannedThreadSchema],
        )

    async def setup_default_admin(self, email: str, password: str, is_super: bool = False) -> None:
        try:
            user = UserModel(email=email, password_hash=bcrypt.hash(password))
            await user.save()
            await AdminModel(admin_user=user, is_super=is_super).save()
        except:
            self._log.error("Error in creating an admin account")
        else:
            self._log.info("Creating account email: %s pw: %s super: %s", email, password, is_super)

    @property
    def router(self) -> APIRouter:
        """FastAPI Router Instance.

        Returns:
            APIRouter: This class api router.
        """
        return self._routing

    async def _internal_get_appointments(self, filter: str) -> List[AppointmentInfoApi]:
        self._log.info("Get %s appointments", filter)
        ap_list = []

        if filter == "all":
            ap_list = await AppointmentModel.all().order_by("-start_time")
        if filter == "pending":
            ap_list = await AppointmentModel.filter(status=AppointmentStatus.PENDING).order_by("-start_time")
        if filter == "approved":
            ap_list = await AppointmentModel.filter(status=AppointmentStatus.RESERVED).order_by("-start_time")
        if filter == "today":
            ap_list = await AppointmentModel.filter(start_time__startswith=date.today().isoformat())

        return [await AppointmentInfoApi.from_model(ap) for ap in ap_list]

    async def admin_get_appointments(
        self,
        filter: _AdminAppointmentFilter = "all",
        admin: UserProfileApi = Depends(get_admin_user),
    ) -> List[AppointmentInfoApi]:
        return await self._internal_get_appointments(filter=filter)

    async def admin_get_appointment_today(
        self, admin: UserProfileApi = Depends(get_admin_user)
    ) -> List[AppointmentInfoApi]:
        self._log.info("Get Today's Appointments")
        return await self._internal_get_appointments(filter=_AdminAppointmentFilter.TODAY)

    async def admin_update_appointment(
        self,
        appointment_id: int,
        update_status: AppointmentUpdateStatusApi,
        admin: UserProfileApi = Depends(get_admin_user),
    ) -> AppointmentInfoApi:
        try:
            ap: AppointmentModel = await AppointmentModel.get(id=appointment_id)
        except DoesNotExist as exc:
            raise HTTPException(status.HTTP_404_NOT_FOUND, detail="Appointment {appointment_id} invalid") from exc

        if ap.status == AppointmentStatus.PENDING and update_status.status == AppointmentStatus.RESERVED:
            user_db: UserModel = await ap.patient
            # await notify_change_appointment_status(user_db.id, ap.start_time, "Approved")
        elif ap.status == AppointmentStatus.PENDING and update_status.status == AppointmentStatus.CANCELLED:
            user_db: UserModel = await ap.patient
            # await notify_change_appointment_status(user_db.id, ap.start_time, "Rejected")

        if ap.status != update_status.status:
            ap.status = update_status.status
            await ap.save()

        return await AppointmentInfoApi.from_model(ap)

    async def admin_get_stats(self, admin: UserProfileApi = Depends(get_admin_user)) -> AdminStatsApi:
        appointment_stats = {stats.service: stats.count for stats in await AppointmentServiceModelStats.all()}
        total_stats = sum([stats for stats in appointment_stats.values()])
        services_percentages = {k: int(100 * v / total_stats) if total_stats else 0 for k, v in appointment_stats.items()}
        return AdminStatsApi(
            num_patients=await UserModel.all().count() - await AdminModel.all().count(),
            num_appointments_req=await AppointmentModel.filter(status=AppointmentStatus.PENDING).count(),
            num_todays_sessions=await AppointmentModel.filter(start_time__startswith=date.today().isoformat()).count(),
            services_percentages=services_percentages,
        )

    async def _internal_admin_user_action(self, user_id: int, action: _AdminUserAction) -> None:
        try:
            user: UserModel = await UserModel.get(id=user_id)

            if action == "delete":
                self._log.critical("deleting user %s", user_id)
                await ArchiveUserModel.archive(user)
                await user.delete()

            if action == "ban":
                self._log.critical("banning user %s", user_id)
                if not await BannedUsersModel.exists(user=user, status=True):
                    # this user is not yet banned, ban now
                    await BannedUsersModel(user=user).save()

            if action == "unban":
                try:
                    ban_status = await BannedUsersModel.get(user=user, status=True)
                    # unset the ban status
                    self._log.critical("unbanning user %s", user_id)
                    ban_status.status = False
                    await ban_status.save()
                except DoesNotExist:
                    # unbanning a user that's not ban, just let it pass
                    pass

        except DoesNotExist as exc:
            raise HTTPException(status.HTTP_404_NOT_FOUND, f"user {user_id} not found") from exc

    async def admin_delete_user(
        self, user_id: int, super_admin: UserProfileApi = Depends(get_super_admin_user)
    ) -> None:
        return await self._internal_admin_user_action(user_id, "delete")

    async def admin_user_action(
        self,
        user_id: int,
        action: _AdminUserAction,
        super_admin: UserProfileApi = Depends(get_super_admin_user),
    ) -> None:
        return await self._internal_admin_user_action(user_id, action)

    async def admin_get_user_list(self, admin: UserProfileApi = Depends(get_super_admin_user)) -> List[UserModel]:
        profiles = []
        for profile in [UserProfileApi.from_model(model) for model in await UserModel.all().order_by("-created")]:
            if await BannedUsersModel.exists(user__id=profile.id, status=True):
                # Quick fix, TODO: put this in from model
                profile.status = "BANNED"
            else:
                profiles += [profile]
        return profiles

    async def admin_get_user(
        self, user_id: int, admin: UserProfileApi = Depends(get_super_admin_user)
    ) -> UserProfileApi:
        try:
            return UserProfileApi.from_model(await UserModel.get(id=user_id))
        except DoesNotExist as exc:
            raise HTTPException(status.HTTP_404_NOT_FOUND, f"user {user_id} not found") from exc

    async def admin_archive_get(
        self,
        id: Optional[int] = None,
        email: Optional[str] = None,
        admin: UserProfileApi = Depends(get_super_admin_user),
    ) -> None:
        self._log.error("Get all archives with filter (id: %s, email: %s)", id, email)
        _filter = {}
        if id:
            _filter["id"] = id
        if email:
            _filter["email"] = email
        if not _filter:
            raise HTTPException(status.HTTP_400_BAD_REQUEST, f"Invalid Query Parameters.")
        try:
            return await ArchiveUserSchema.from_queryset_single(ArchiveUserModel.get(**_filter))
        except DoesNotExist:
            raise HTTPException(status.HTTP_404_NOT_FOUND, f"cannot find archive with filter {_filter}")

    async def admin_recover_user(
        self, email: str, admin: UserProfileApi = Depends(get_super_admin_user)
    ) -> UserProfileApi:
        """Recover a user account using user email."""
        self._log.error("Recovering user %s", email)
        if await UserModel.exists(email=email):
            # check if this user is active, if not then recover
            self._log.error("User is still active")
            raise HTTPException(status.HTTP_400_BAD_REQUEST, f"User profile with {email} already exists")
        try:
            archive = await ArchiveUserModel.get(email=email)
        except DoesNotExist:
            self._log.error("Archive with email %s does not exist", email)
            raise HTTPException(status.HTTP_404_NOT_FOUND, f"Profile with email {email} never existed.")

        user = UserProfileApi.from_model(await archive.recover(email=email))
        # then delete the archive profile
        await archive.delete()
        self._log.error("User successfully recovered %s", archive)
        return user

    async def admin_archive_get_all(
        self, admin: UserProfileApi = Depends(get_super_admin_user)
    ) -> List[ArchiveUserSchema]:
        """Get all archive data model."""
        return await ArchiveUserSchema.from_queryset(ArchiveUserModel.all().order_by("-archived_when"))

    async def get_banned_thread_list(self) -> List[BannedThreadSchema]:
        return await BannedThreadSchema.from_queryset(BannedThreadModel.all().order_by("-created"))

    async def admin_get_banned_users(
        self, admin: UserProfileApi = Depends(get_super_admin_user)
    ) -> List[UserProfileApi]:
        data = [
            UserProfileApi.from_model(await model.user) for model in await BannedUsersModel.filter(status=True)
        ]
        self._log.info("Get all banned users %s...", data)
        return data
