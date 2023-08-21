import os
import asyncio
import logging
from typing import List, Dict, Any

from fastapi import FastAPI, APIRouter, Response, status
from pydantic import BaseModel

# internal modules
from internal.database import Database
from internal.schema import User

log = logging.getLogger(__name__)

app = FastAPI()
database = Database("")


class Account:
    def __init__(self) -> None:
        self._router = APIRouter()
        self._router.add_api_route("/", endpoint=self.root, methods=["GET"])

    @property
    def router(self) -> APIRouter:
        return self._router

    async def root(self) -> Dict[str, Any]:
        return {"message": "Hello World"}


@app.post("/account/login", status_code=status.HTTP_200_OK)
async def account_login(user: User, response: Response):
    """Login Account route."""
    if database.get_account(user.email) is None:
        response.status_code = status.HTTP_401_UNAUTHORIZED

@app.post("/account/register", status_code=status.HTTP_200_OK)
async def account_register(user: User, response: Response):
    """Create Account route."""
    if database.get_account(user.email) is None:
        database.create_account(user.email, user.name, user.password)
    else:
        # email is already taken
        response.status_code = status.HTTP_409_CONFLICT

@app.post("/account/logout")
async def account_logout(user: User):
    pass


account = Account()
app.include_router(account.router)
