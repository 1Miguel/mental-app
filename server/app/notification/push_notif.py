import asyncio
from datetime import datetime
from typing import List, Dict, Optional
from pydantic import BaseModel, Field
from onesignal_sdk.client import AsyncClient
from onesignal_sdk.response import  OneSignalResponse
from onesignal_sdk.error import OneSignalHTTPError


ONESIGNAL_API_KEY = 'NTQ0ZDgxMTAtMTczMS00ZjkzLWI5M2UtNzljYmMzOGJhYmUz'
ONESIGNAL_APP_ID = 'b44afb89-b2cb-4382-96a2-edac8b13caa9'

message = "Test Message 1 2 3!!"
title = "This is a Targeted Message!!"
device_token = ""

client = AsyncClient(app_id=ONESIGNAL_APP_ID, rest_api_key=ONESIGNAL_API_KEY)

class Notification(BaseModel):
    app_id: str
    name: str
    included_segments: List[str]
    contents: Dict[str, str]
    include_aliases: Dict[str, List[str]] = Field(default_factory=dict)
    target_channel: str = ""

new_notification = {
    "app_id": ONESIGNAL_APP_ID,
    "included_segments": ['Active Subscriptions'],
    "contents": {
        "en": "English or Any Language Message",
        "es": "Spanish Message",
    },
    "name": "INTERNAL_CAMPAIGN_NAME",
}

async def push_notify(
    name: str,
    segments: List[str],
    contents: Dict[str, str],
    *,
    external_ids: Optional[List[str]]=None,
    onesignal_ids: Optional[List[str]]=None,
    app_id: str = ONESIGNAL_APP_ID,
    **kwargs
) -> None:
    include_aliases = {}
    if external_ids:
        include_aliases["external_id"] = external_ids
    if onesignal_ids:
        include_aliases["onesignal_id"] = onesignal_ids
    if include_aliases:
        kwargs["include_aliases"] = include_aliases

    # specify channel is "push" notify
    kwargs["name"] = name
    kwargs["segments"] = segments
    kwargs["contents"] = contents
    kwargs["app_id"] = app_id
    kwargs["target_channel"] = "push"
    notification = Notification(**kwargs)
    try:
        response: OneSignalResponse = await client.send_notification(notification.model_dump())
    except OneSignalHTTPError as exc:
        response = exc
    message = response.message  if isinstance(response, OneSignalHTTPError) else response.body
    return response.http_response, response.status_code, message

async def notify_change_appointment_status(user_id: int, date: datetime, status: str) -> None:
    await push_notify(
        name = "INTERNAL_CAMPAIGN_NAME",
        segments=["Appointment Status Changed"],
        app_id =  ONESIGNAL_APP_ID,
        contents =  {
            "en" : f"Appointment for {date.strftime('%d-%m-%Y at %I:%M %p')} was {status}",
        },
        included_segments =  ['Active Subscriptions'],
        external_ids=[f"userId_{user_id}"]
    )

async def notify_change_thread(user_id: int, message: str) -> None:
    await push_notify(
        name = "INTERNAL_CAMPAIGN_NAME",
        segments=["Thread"],
        app_id =  ONESIGNAL_APP_ID,
        contents =  {
            "en" : message,
        },
        included_segments =  ['Active Subscriptions'],
        external_ids=[f"userId_{user_id}"]
    )

async def main():
    # target_external_id = "user_12345678"
    # response: OneSignalResponse = await push_notify(
    #     name = "INTERNAL_CAMPAIGN_NAME",
    #     app_id =  ONESIGNAL_APP_ID,
    #     contents =  {
    #         "en" : f"This is a targeted message to {target_external_id}",
    #     },
    #     included_segments =  ['Active Subscriptions'],
        
    #     external_ids=[target_external_id]
    # )
    # print(response)
    # await asyncio.sleep(3)
    await notify_change_appointment_status(12345678, datetime.now(), "approved")
