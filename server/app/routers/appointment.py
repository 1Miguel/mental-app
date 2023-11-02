"""Collection of all API routings related to Appointment Services.

date: 02/11/2023
"""
# ---- Standard
from typing import List, Optional

# ---- Thirdparty
from fastapi.routing import APIRouter

# ---- Locals
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

    def __init__(self, router: Optional[APIRouter] = None) -> None:
        self._routing = router if router else APIRouter()
        # ---- Set all routes
        self._routing.add_api_route(
            "user/appointment/new/",
            self.new_appointment,
            methods=["POST"],
        )
        self._routing.add_api_route(
            "user/appointment/{appointment_id}",
            self.get_appointment,
            methods=["GET"],
            response_model=AppointmentInfoApi
        )
        self._routing.add_api_route(
            "user/appointment/{appointment_id}/reschedule",
            self.reschedule_appointment,
            methods=["POST"],
        )
        self._routing.add_api_route(
            "user/appointment/{appointment_id}/cancel",
            self.cancel_appointment,
            methods=["POST"],
        )
        self._routing.add_api_route(
            "user/appointment/available/{year}/{month}/{day}/",
            self.get_available_slots,
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

    async def get_appointment(self, appointment_id: int) -> AppointmentInfoApi:
        pass

    async def get_available_slots(self, year: int, month: Optional[int]=None, day: Optional[int]=None, limit: Optional[int]=None) -> List[AppointmentBlockedSlot]:
        pass

    async def new_appointment(self, appointment_info: AppointmentInfoApi) -> None:
        pass

    async def reschedule_appointment(self, appointment_id: int) -> None:
        pass

    async def cancel_appointment(self, appointment_id: int) -> None:
        pass

