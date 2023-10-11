"""Behave test steps for account feature.

date: 10/08/2023
"""
import logging
import httpx

from behave import given, when, then
from behave.runner import Context
from behave.api import async_step
from http_status import HTTPStatusCode

log = logging.getLogger("Account Steps")

@given(u"User account is {action} registered")
def step_given_user_account(context: Context, action: str) -> None:
    log.critical("Test Log")
    pass

@when(u"User creates account")
def step_create_account(context: Context) -> None:
    pass

@then(u"Server must return response {http_response}")
def step_then_server_response(context: Context, http_response: str) -> None:
    pass

@when(u"User log in")
def step_create_account(context: Context) -> None:
    pass