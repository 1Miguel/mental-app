"""Collection of all API routings related to Admin Services.

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
from internal.database import *
from internal.schema import *


class AdminManager:

    def __init__(
        self, router: Optional[APIRouter] = None, log: Optional[logging.Logger] = None
    ) -> None:
        self._log = log if log else logging.getLogger(__name__)
        self._routing = router if router else APIRouter()
        # ---- Set all routes
        self._routing.add_api_route(
            "/admin/appointment/",
            self.admin_get_appointments,
            methods=["GET"],
            response_model=List[AppointmentInfoApi],
            description="Returns all appointment data stored in the database."
        )
        self._routing.add_api_route(
            "/admin/appointment/{appointment_id}/update",
            self.admin_update_appointment,
            methods=["GET"],
            response_model=AppointmentInfoApi,
            description="Updates the appointment status."
        )

    @property
    def router(self) -> APIRouter:
        """FastAPI Router Instance.

        Returns:
            APIRouter: This class api router.
        """
        return self._routing

    async def admin_get_appointments(
        admin: UserProfileApi = Depends(get_admin_user),
    ) -> List[AppointmentInfoApi]:
        ap: Appointment
        appointment_list = []
        for ap in await Appointment.all():
            p: UserModel = await ap.patient
            appointment_list += [
                AppointmentInfoApi(
                    id=ap.id,
                    patient_id=p.id,
                    center="",
                    start_time=ap.start_time.isoformat(),
                    end_time=ap.end_time.isoformat(),
                    status=ap.status.value,
                )
            ]
        return appointment_list