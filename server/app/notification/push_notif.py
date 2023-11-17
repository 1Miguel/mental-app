# --------------------------------
# std imports
# --------------------------------
import logging
from datetime import datetime
from typing import List, Dict, Optional

# --------------------------------
# third party imports
# --------------------------------
# ----- datamodel
from pydantic import BaseModel, Field

# ----- database
from tortoise.contrib.pydantic import pydantic_model_creator
from tortoise.exceptions import DoesNotExist

# ----- fastapi
from fastapi import HTTPException, status, Depends, Path
from fastapi.routing import APIRouter

# ----- onesignal notifier
from onesignal_sdk.client import AsyncClient
from onesignal_sdk.response import OneSignalResponse
from onesignal_sdk.error import OneSignalHTTPError

# --------------------------------
# internal imports
# --------------------------------
from routers.account import get_current_user
from internal.database import *
from internal.schema import *

DEFAULT_SEGMENT = "Subscribed Users"
ONESIGNAL_API_KEY = "NTQ0ZDgxMTAtMTczMS00ZjkzLWI5M2UtNzljYmMzOGJhYmUz"
ONESIGNAL_APP_ID = "b44afb89-b2cb-4382-96a2-edac8b13caa9"

NotificationSchema = pydantic_model_creator(NotificationMessageModel)


class _Notification(BaseModel):
    app_id: str
    name: str
    included_segments: List[str]
    contents: Dict[str, str]
    include_aliases: Dict[str, List[str]] = Field(default_factory=dict)
    target_channel: str = ""
    custom_data: Dict[str, Any] = Field(default_factory=dict)


class Notifier(object):
    def __new__(cls):
        if not hasattr(cls, "instance"):
            cls.instance = super(Notifier, cls).__new__(cls)
        return cls.instance

    def __init__(
        self,
        router: Optional[APIRouter] = None,
        log: Optional[logging.Logger] = None,
    ) -> None:
        self._log = log if log else logging.getLogger(__name__)
        self._routing = router if router else APIRouter()
        self._client = AsyncClient(app_id=ONESIGNAL_APP_ID, rest_api_key=ONESIGNAL_API_KEY)
        #: ---- Set all routes
        self._routing.add_api_route(
            "/user/notification/{notif_id}",
            self.get_notification,
            methods=["POST"],
        )
        self._routing.add_api_route("/user/notification/}", self.get_all_notificaton, methods=["POST"])

    async def _new_segment(self, name: str) -> OneSignalResponse:
        return await self._client.create_segment({"name": name})

    async def _push_notify(
        self,
        name: str,
        segments: List[str],
        contents: Dict[str, str],
        *,
        external_ids: Optional[List[str]] = None,
        onesignal_ids: Optional[List[str]] = None,
        app_id: str = ONESIGNAL_APP_ID,
        custom_data: Optional[Dict[str, Any]] = None,
        **kwargs,
    ) -> None:
        include_aliases = {}
        if external_ids:
            include_aliases["external_id"] = external_ids
        if onesignal_ids:
            include_aliases["onesignal_id"] = onesignal_ids
        if include_aliases:
            kwargs["include_aliases"] = include_aliases
        if custom_data:
            kwargs["custom_data"] = custom_data

        # specify channel is "push" notify
        kwargs["name"] = name
        kwargs["included_segments"] = segments
        kwargs["contents"] = contents
        kwargs["app_id"] = app_id
        kwargs["target_channel"] = "push"

        notification = _Notification(**kwargs)
        self._log.info("Sending notification %s", notification)
        try:
            response: OneSignalResponse = await self._client.send_notification(notification.model_dump())
        except OneSignalHTTPError as exc:
            response = exc
        message = response.message if isinstance(response, OneSignalHTTPError) else response.body
        return response.http_response, response.status_code, message

    async def notify(
        self,
        user: UserModel,
        segment: str,
        topic: str,
        title: str,
        message: str,
    ) -> None:
        """Send a push notification to a user."""
        await NotificationMessageModel.create(user=user, segment=segment, title=title, message=message)
        await self._push_notify(
            title,
            segments=[
                DEFAULT_SEGMENT,
            ],
            contents={
                "en": message,
            },
            external_ids=[
                f"userId_{user.id}",
            ],
            custom_data={
                "topic": topic,
            },
        )

    async def get_notification(
        self, notif_id: int, user: UserProfileApi = Depends(get_current_user)
    ) -> NotificationSchema:
        """GET a notification data.

        Args:
            notif_id (int): Assigned Notification Id.
            user (UserModel): User Profile.

        Raises:
            HTTPException: 404 if notification not found.

        Returns:
            NotificationSchema: Notification data.
        """
        try:
            notif_data = await NotificationMessageModel.get(user__id=user.id, id=notif_id)
        except DoesNotExist:
            raise HTTPException(status.HTTP_404_NOT_FOUND, detail="Notificaton not found.")
        return NotificationSchema.from_tortoise_orm(notif_data)

    async def get_all_notificaton(self, user: UserProfileApi = Depends(get_current_user)) -> List[NotificationSchema]:
        """GET all user history of notifications from the database.

        Args:
            user (UserModel): User Profile.

        Returns:
            List[NotificationSchema]: List of notifications.
        """
        return [
            await NotificationSchema.from_tortoise_orm(notif_data)
            for notif_data in await NotificationMessageModel.filter(user__id=user.id).order_by("-created")
        ]
