"""Collection of all API routings related to Admin Services.

date: 02/11/2023
"""
# ---- Standard
import logging
from typing import List, Optional
from datetime import datetime, date

# ---- Thirdparty
from fastapi import HTTPException, status, Depends, Path
from fastapi.routing import APIRouter
from tortoise.exceptions import DoesNotExist

# ---- Locals
from routers.account import get_admin_user
from internal.database import *
from internal.schema import *


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

    async def setup_default_admin(self) -> None:
        try:
            user = UserModel(
                email="admin0@mentalapp.com",
                password_hash=bcrypt.hash("testadminpassword"),
            )
            await user.save()
            await AdminModel(admin_user=user).save()
        except:
            self._log.error("Error in creating an admin account")

    @property
    def router(self) -> APIRouter:
        """FastAPI Router Instance.

        Returns:
            APIRouter: This class api router.
        """
        return self._routing

    async def admin_get_appointments(self, admin: UserProfileApi = Depends(get_admin_user)) -> List[AppointmentInfoApi]:
        self._log.info("Get All Appointments")
        return [await AppointmentInfoApi.from_model(ap) for ap in await AppointmentModel.all().order_by("-start_time")]

    async def admin_get_appointment_today(
        self, admin: UserProfileApi = Depends(get_admin_user)
    ) -> List[AppointmentInfoApi]:
        self._log.info("Get Today's Appointments")
        today = date.today().isoformat()
        return [
            await AppointmentInfoApi.from_model(ap)
            for ap in await AppointmentModel.filter(start_time__startswith=today)
        ]

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

        if ap.status != update_status.status:
            ap.status = update_status.status
            await ap.save()

        return await AppointmentInfoApi.from_model(ap)

    async def admin_get_stats(self, admin: UserProfileApi = Depends(get_admin_user)) -> AdminStatsApi:
        return AdminStatsApi(
            num_patients=await UserModel.all().count() - await AdminModel.all().count(),
            num_appointments_req=await AppointmentModel.filter(status=AppointmentStatus.PENDING).count(),
            num_todays_sessions=await AppointmentModel.filter(start_time__startswith=date.today().isoformat()).count(),
        )
