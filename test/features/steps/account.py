import httpx
import behave

from http_status import HTTPStatusCode
from behave.runner import Context
from behave.api import async_step

@behave.given(u"User account is {action} registered")
def step_given_user_account(context: Context, action: str) -> None:
    print(action)

@behave.when(u"User creates account")
def step_create_account(context: Context) -> None:
    pass

@behave.then(u"Server must return response {http_response}")
def step_then_server_response(context: Context, http_response: str) -> None:
    pass

@behave.when(u"User log in")
def step_create_account(context: Context) -> None:
    pass