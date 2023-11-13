"""Collection of all API routings related to Mood Logging Services.

date: 02/11/2023
"""
# ---- Standard
import logging
from typing import List, Optional
from datetime import date

# ---- Thirdparty
from fastapi import HTTPException, status, Depends
from fastapi.routing import APIRouter
from tortoise.exceptions import DoesNotExist

# ---- Locals
from routers.account import get_current_user
from internal.database import *
from internal.schema import *


class MoodLogger:
    """Mood Logger Class that contains all routes that is
    related to Mood logging services."""

    def __init__(self, router: Optional[APIRouter] = None, log: Optional[logging.Logger] = None) -> None:
        self._log = log if log else logging.getLogger(__name__)
        self._routing = router if router else APIRouter()
        # ---- Set all routes
        self._routing.add_api_route(
            "/user/mood/log/",
            self.set_mood,
            methods=["POST"],
        )
        self._routing.add_api_route(
            "/user/mood/{year}/{month}/{day}/",
            self.get_mood_list,
            methods=["GET"],
            response_model=MoodListResponse,
        )
        self._routing.add_api_route(
            "/user/mood/{year}/{month}/",
            self.get_mood_list,
            methods=["GET"],
            response_model=MoodListResponse,
        )

    @property
    def router(self) -> APIRouter:
        """FastAPI Router Instance.

        Returns:
            APIRouter: This class api router.
        """
        return self._routing

    async def set_mood(self, mood: MoodLog, user: UserProfileApi = Depends(get_current_user)) -> None:
        """Daily Mood Logging. if mood score has been log for today, dont lot anymore
        and return an HTTP_409_CONFLICT error."""
        # validate mood id
        try:
            mood_id = MoodId(mood.mood)
            if mood_id == MoodId.UNDEFINED:
                raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Invalid Data.")
        except ValueError:
            self._log.error("Invalid mood id %s.", mood.mood)
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Invalid Data.")

        user = await UserModel.get(email=user.email)
        today = date.today() if not mood.date else mood.date
        try:
            mood_db = await MoodModel.get(user=user, date=today)
            self._log.info("user %s:%s|Mood %s already exist", user.id, user.email, mood_db.id)
            self._log.info("user %s:%s|Re-logging mood.", user.id, user.email)
            mood_db.mood = mood_id
            mood_db.note = mood.note
        except DoesNotExist:  # no data log today, create a new data to save
            self._log.info("user %s:%s|Sucess logging new mood.", user.id, user.email)
            mood_db = MoodModel(user=user, mood=mood_id, date=today, note=mood.note)

        await mood_db.save()

    async def get_mood_list(
        self,
        year: int,
        month: int,
        day: Optional[int] = None,
        limit: Optional[int] = None,
        user: UserProfileApi = Depends(get_current_user),
    ) -> MoodListResponse:
        # ---- 1. Query list of mood data base on date and user
        date_time_q = f"{year:04}-{month:02}"
        if day is not None:
            date_time_q += f"-{day:02}"
        mood_db_list: List[MoodModel] = (
            await MoodModel.filter(user__id=user.id, date__startswith=date_time_q).all().order_by("-date")
        )
        self._log.info("user %s:%s | Filter all moods at %s | num moods: %s", user.id, user.email, date_time_q, len(mood_db_list))

        # ---- 2. Iterate thru all the moods and build a response
        response = MoodListResponse(percentages=[0] * (MoodId.NUM_MOODS - 1), mood_list=[])
        for mood_db_data in mood_db_list:
            mood_log_data = MoodLog(mood=mood_db_data.mood, note=mood_db_data.note, date=mood_db_data.date.isoformat())
            response.percentages[mood_db_data.mood - 1] += 1
            response.mood_list += [mood_log_data]
            self._log.info(mood_log_data)

        # ---- 3. Calculate percentage base on moods
        num_moods = len(response.mood_list)
        response.percentages = [int(100 * p / num_moods) if num_moods else 0 for p in response.percentages]

        return response
