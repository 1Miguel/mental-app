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
from routers.account import get_admin_user
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
            description="Returns all appointment data stored in the database.",
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
                firstname="",
                lastname="",
                address="",
                age=0,
                occupation="",
                birthday=datetime(year=1900, month=1, day=1).isoformat(),
            )
            await user.save()
            await AdminModel(admin_user=user).save()
        except:
            pass

    @property
    def router(self) -> APIRouter:
        """FastAPI Router Instance.

        Returns:
            APIRouter: This class api router.
        """
        return self._routing

    async def admin_get_appointments(self, admin: UserProfileApi = Depends(get_admin_user)) -> List[AppointmentInfoApi]:
        ap: AppointmentModel
        appointment_list = []
        for ap in await AppointmentModel.all():
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

    async def admin_update_appointment(
        self, appointment_id: int, update_status: AppointmentUpdateStatusApi, admin: UserProfileApi = Depends(get_admin_user)
    ) -> AppointmentInfoApi:
        try:
            ap: AppointmentModel = await AppointmentModel.get(id=appointment_id)
        except DoesNotExist as exc:
            raise HTTPException(
                status.HTTP_404_NOT_FOUND, detail="Appointment {appointment_id} invalid"
            ) from exc
    
        if ap.status != update_status.status:
            ap.status = update_status.status
            await ap.save()

        return await AppointmentInfoApi.from_model(ap)