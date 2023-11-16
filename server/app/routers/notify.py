# --------------------------------
# std imports
# --------------------------------
import logging
from typing import List, Dict, Optional

# --------------------------------
# third party imports
# --------------------------------
# ----- datamodel
from pydantic import BaseModel, Field

# ----- database
from tortoise.contrib.pydantic import pydantic_model_creator

# ----- onesignal notifier
from onesignal_sdk.client import AsyncClient
from onesignal_sdk.response import OneSignalResponse
from onesignal_sdk.error import OneSignalHTTPError

# --------------------------------
# internal imports
# --------------------------------
from internal.database import *
from internal.schema import *

DEFAULT_SEGMENT = "Total Subscriptions"
ONESIGNAL_API_KEY = "NTQ0ZDgxMTAtMTczMS00ZjkzLWI5M2UtNzljYmMzOGJhYmUz"
ONESIGNAL_APP_ID = "b44afb89-b2cb-4382-96a2-edac8b13caa9"

NotificationSchema = pydantic_model_creator(NotificationMessageModel)


class _Notification(BaseModel):
    app_id: str
    name: str
    included_segments: List[str]
    contents: Dict[str, str]
    # include_aliases: Dict[str, List[str]] = Field(default_factory=dict)
    target_channel: str = ""
    custom_data: Dict[str, Any] = Field(default_factory=dict)


class Notifier(object):
    def __new__(cls, *args, **kwargs):
        if not hasattr(cls, "instance"):
            cls.instance = super(Notifier, cls).__new__(cls, *args, **kwargs)
        return cls.instance

    def __init__(
        self,
        log: Optional[logging.Logger] = None,
    ) -> None:
        self._log = log if log else logging.getLogger(__name__)
        self._client = AsyncClient(app_id=ONESIGNAL_APP_ID, rest_api_key=ONESIGNAL_API_KEY)

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
        # if include_aliases:
        #     kwargs["include_aliases"] = include_aliases
        if custom_data:
            kwargs["custom_data"] = custom_data

        # specify channel is "push" notify
        kwargs["included_segments"] = segments
        kwargs["name"] = name
        kwargs["contents"] = contents
        kwargs["app_id"] = app_id
        # kwargs["target_channel"] = "push"

        self._log.info("Sending notification %s", kwargs)
        try:
            response: OneSignalResponse = await self._client.send_notification(kwargs)
            self._log.info(
                "OneSignal Response: %s | %s | %s",
                response.http_response,
                response.status_code,
                response.body,
            )
        except OneSignalHTTPError as exc:
            self._log.error(
                "OneSignal Erorr: %s | %s | %s", exc.http_response, exc.status_code, exc.message
            )

    async def notify(
        self, user: UserModel, topic: str, title: str, message: str, *, segment=DEFAULT_SEGMENT
    ) -> None:
        """Send a push notification to a user."""
        await NotificationMessageModel.create(
            user=user, segment=segment, title=title, message=message
        )
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
