"""Collection of all API routings related to Appointment Services.

date: 02/11/2023
"""
# ---- Standard
import logging
from typing import List, Optional
from datetime import datetime

# ---- Thirdparty
from fastapi import HTTPException, status, Depends, Path
from fastapi.routing import APIRouter
from tortoise.exceptions import DoesNotExist

# ---- Locals
from routers.account import get_current_user
from routers.notify import NotificationSchema, Notifier
from internal.database import *
from internal.schema import *


class Appointment:
    """Appointment Class that contains all routes that is
    related to appointment services.

      Supported Routes:
    ---------------------

        1. Appointment New/Cancel/Reschedule:
                user/appointment/{year}/{month}/{day}/{appointment_id}/[action]
                                                                        ↑
                definition:                                               |
                -------------                                             |                                                                |
                [reschedule/cancel/new] ----------------------------------+

        2. Appointment View(GET):
                This returns all appointment depending on the given route.

                user/appointment/{year}/{month}/{day}/{appointment_id}
                |--------------------------|      |         |
                            |                     |         |
                        in a month                |         |
                |---------------------------------+         |
                                |                           |
                            in a day                       |
                |-------------------------------------------+
                                    |
                            specific appointment
    """

    def __init__(
        self, router: Optional[APIRouter] = None, log: Optional[logging.Logger] = None
    ) -> None:
        self._log = log if log else logging.getLogger(__name__)
        self._routing = router if router else APIRouter()
        self._notifier = Notifier()

        # ---- POST methods
        self._routing.add_api_route(
            "/user/appointment/new/",
            self.new_appointment,
            methods=["POST"],
            response_model=AppointmentInfoApi,
        )
        self._routing.add_api_route(
            "/user/appointment/myschedule/{appointment_id}/reschedule/",
            self.reschedule_user_appointment,
            methods=["POST"],
            response_model=AppointmentInfoApi,
        )
        self._routing.add_api_route(
            "/user/appointment/myschedule/{appointment_id}/cancel/",
            self.cancel_user_appointment,
            methods=["POST"],
        )
        # ---- GET methods
        self._routing.add_api_route(
            "/user/appointment/myschedule/upcoming/",
            self.get_user_upcoming_appointment_schedules,
            methods=["GET"],
            response_model=List[AppointmentInfoApi],
        )
        self._routing.add_api_route(
            "/user/appointment/myschedule/previous/",
            self.get_user_previous_appointment_schedules,
            methods=["GET"],
            response_model=List[AppointmentInfoApi],
        )
        self._routing.add_api_route(
            "/user/appointment/myschedule/pending/",
            self.get_user_pending_appointment_schedules,
            methods=["GET"],
            response_model=List[AppointmentInfoApi],
        )
        self._routing.add_api_route(
            "/user/appointment/myschedule/{appointment_id}",
            self.get_user_appointment,
            methods=["GET"],
            response_model=AppointmentInfoApi,
        )
        self._routing.add_api_route(
            "/user/appointment/schedule/{year}/{month}/{day}/",
            self.get_blocked_day_appointment_slots,
            methods=["GET"],
            response_model=List[AppointmentBlockedSlot],
        )
        self._routing.add_api_route(
            "/user/appointment/schedule/{year}/{month}/",
            self.get_blocked_month_appointment_slots,
            methods=["GET"],
            response_model=List[AppointmentBlockedSlot],
        )

    @property
    def router(self) -> APIRouter:
        """FastAPI Router Instance.

        Returns:
            APIRouter: This class api router.
        """
        return self._routing

    async def get_blocked_month_appointment_slots(
        self,
        year: int = Path(ge=2000, le=3000),
        month: Optional[int] = Path(ge=1, le=12),
        limit: Optional[int] = 31,
        user: UserProfileApi = Depends(get_current_user),
    ) -> List[AppointmentBlockedSlot]:
        return await self._get_blocked_appointment_slots(year, month, None, limit, user)

    async def get_blocked_day_appointment_slots(
        self,
        year: int = Path(ge=2000, le=3000),
        month: Optional[int] = Path(ge=1, le=12),
        day: Optional[int] = Path(ge=1, le=31),
        limit: Optional[int] = 31,
        user: UserProfileApi = Depends(get_current_user),
    ) -> List[AppointmentBlockedSlot]:
        return await self._get_blocked_appointment_slots(year, month, day, limit, user)

    async def _get_blocked_appointment_slots(
        self,
        year: int,
        month: int,
        day: int,
        limit: int,
        user: UserProfileApi,
    ) -> List[AppointmentBlockedSlot]:
        date_time_q = f"{year:04}"
        if month is not None:
            date_time_q += f"-{month:02}"
        if day is not None:
            date_time_q += f"-{day:02}"
        self._log.info("get all available appointments %s", date_time_q)

        response = [
            await AppointmentBlockedSlot.from_model(ap)
            for ap in await AppointmentModel.filter(start_time__startswith=date_time_q).all()
        ]
        return response

    async def _schedule_new_appointment(
        self, appointment_api: AppointmentApi, user: UserProfileApi
    ) -> AppointmentInfoApi:
        # ----- 1. check if this slot is already taken
        if await AppointmentModel.exists(start_time__startswith=appointment_api.start_time):
            # appointment is already blocked
            self._log.critical("Attempted to set appointment to an already blocked slot.")
            raise HTTPException(status.HTTP_409_CONFLICT, "Appointment slot already blocked.")

        # ----- 2. Create a new appointment
        self._log.info("Setting appointment...")
        new_appointment = AppointmentModel(
            patient=await UserModel.get(id=user.id),
            service=appointment_api.service,
            start_time=appointment_api.start_time,
            end_time=appointment_api.end_time,
            status=AppointmentStatus.PENDING,
            concerns=appointment_api.concerns,
        )
        # ----- 3. Save this to database
        await new_appointment.save()

        # ----- 4. count
        self._log.info("New appointment with service %s", appointment_api.service)
        stats = await AppointmentServiceModelStats.get(service=appointment_api.service)
        stats.count += 1
        await stats.save()

        # ----- 5. Return a response
        return await AppointmentInfoApi.from_model(new_appointment)

    async def new_appointment(
        self, appointment_api: AppointmentApi, user: UserProfileApi = Depends(get_current_user)
    ) -> AppointmentInfoApi:
        """A user sets a new appointment"""
        return await self._schedule_new_appointment(appointment_api, user)

    async def get_user_upcoming_appointment_schedules(
        self, limit: int = 1, user: UserProfileApi = Depends(get_current_user)
    ) -> List[AppointmentInfoApi]:
        """Returns all the schedule slots that belong to the user."""
        appointments = [
            await AppointmentInfoApi.from_model(appointment)
            for appointment in await AppointmentModel.filter(
                start_time__gte=datetime.today(),
                status=AppointmentStatus.RESERVED,
                patient__id=user.id,
            )
            .order_by("start_time")
            .limit(limit)
        ]
        self._log.info("Query Upcoming Appointments %s", appointments)
        return appointments

    async def get_user_previous_appointment_schedules(
        self, limit: int = 5, user: UserProfileApi = Depends(get_current_user)
    ) -> List[AppointmentInfoApi]:
        """Returns all the schedule slots that belong to the user."""
        appointments = [
            await AppointmentInfoApi.from_model(appointment)
            for appointment in await AppointmentModel.filter(
                start_time__lt=datetime.today(),
                status=AppointmentStatus.RESERVED,
                patient__id=user.id,
            )
            .order_by("-start_time")
            .limit(limit)
        ]
        self._log.info("Query previous Appointments %s", appointments)
        return appointments

    async def get_user_pending_appointment_schedules(
        self, limit: int = 5, user: UserProfileApi = Depends(get_current_user)
    ) -> List[AppointmentInfoApi]:
        appointments = [
            await AppointmentInfoApi.from_model(appointment)
            for appointment in await AppointmentModel.filter(
                status=AppointmentStatus.PENDING, patient__id=user.id
            )
            .order_by("-created")
            .limit(limit)
        ]
        self._log.info("Query pending Appointments %s", appointments)
        return appointments

    async def get_user_appointment(
        self, appointment_id: int, user: UserProfileApi = Depends(get_current_user)
    ) -> AppointmentInfoApi:
        """Returns the info of a schedule slot the belong to a user by ID."""
        try:
            return await AppointmentInfoApi.from_model(
                await AppointmentModel.get(id=appointment_id, patient__id=user.id)
            )
        except DoesNotExist as exc:
            raise HTTPException(
                status.HTTP_404_NOT_FOUND, "Appointment slot already blocked."
            ) from exc

    async def reschedule_user_appointment(
        self,
        appointment_id: int,
        new_appointment_req: AppointmentApi,
        user: UserProfileApi = Depends(get_current_user),
    ) -> AppointmentInfoApi:
        """Reschedule user appointment."""
        self._log.critical("Rescheduling appointment %s.", appointment_id)
        # ----- 1. Check if this is a valid appointment
        try:
            prev_appointment: AppointmentModel = await AppointmentModel.get(id=appointment_id)
        except DoesNotExist as exc:
            raise HTTPException(status.HTTP_404_NOT_FOUND, "Appointment slot already blocked.")
        # ----- 2. Schedule a new appointment
        response = await self._schedule_new_appointment(new_appointment_req, user)
        # ----- 3. set this previous appointment status as reschedule
        prev_appointment.status = AppointmentStatus.RESCHEDULE
        # ----- 4. and save
        await prev_appointment.save()

        return response

    async def cancel_user_appointment(
        self, appointment_id: int, user: UserProfileApi = Depends(get_current_user)
    ) -> None:
        """Cancel user appointment."""
        self._log.critical("Cancelling appointment %s.", appointment_id)
        # ----- 1. Check if this is a valid appointment
        try:
            prev_appointment: AppointmentModel = await AppointmentModel.get(id=appointment_id)
        except DoesNotExist as exc:
            raise HTTPException(status.HTTP_404_NOT_FOUND, "Appointment slot already blocked.")
        # ----- 2. set this previous appointment status as cancelled
        prev_appointment.status = AppointmentStatus.CANCELLED
        # ----- 3. and save
        await prev_appointment.save()
