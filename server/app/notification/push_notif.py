import asyncio
from typing import List, Dict, Optional
from pydantic import BaseModel, Field
from onesignal_sdk.client import AsyncClient
from onesignal_sdk.response import  OneSignalResponse

ONESIGNAL_API_KEY = 'NTQ0ZDgxMTAtMTczMS00ZjkzLWI5M2UtNzljYmMzOGJhYmUz'
ONESIGNAL_APP_ID = 'b44afb89-b2cb-4382-96a2-edac8b13caa9'

message = "Test Message 1 2 3!!"
title = "This is a Test Message!!"
device_token = ""

client = AsyncClient(app_id=ONESIGNAL_APP_ID, rest_api_key=ONESIGNAL_API_KEY)

class Notification(BaseModel):
    app_id: str
    name: str
    included_segments: List[str]
    contents: Dict[str, str]
    include_aliases: Dict[str, List[str]] = Field(default_factory=dict)

new_notification = {
    "app_id": ONESIGNAL_APP_ID,
    "included_segments": ['Active Subscriptions'],
    "contents": {
        "en": "English or Any Language Message",
        "es": "Spanish Message"
    },
    "name": "INTERNAL_CAMPAIGN_NAME",
}

async def notify(
    external_ids: Optional[List[str]]=None,
    onesignal_ids: Optional[List[str]]=None,
    **kwargs
) -> None:
    include_aliases = {}
    if external_ids:
        include_aliases["external_id"] = external_ids
    if onesignal_ids:
        include_aliases["onesignal_id"] = onesignal_ids
    notification = Notification(**kwargs)
    print(notification)
    response: OneSignalResponse = await client.send_notification(notification.model_dump())
    return response.http_response, response.status_code, response.body

async def main():
    response: OneSignalResponse = await notify(
        app_id =  ONESIGNAL_APP_ID,
        name = "INTERNAL_CAMPAIGN_NAME",
        included_segments =  ['Active Subscriptions'],
        contents =  {
            "en" : "English or Any Language Message",
            "es" : "Spanish Message"
        },
        external_ids=["user_1234"]
    )
    print(response)
    await asyncio.sleep(3)

asyncio.run(main())