import os
import asyncio
import logging
from typing import List, Dict, Any

import jwt
from passlib.hash import bcrypt
from fastapi import FastAPI, HTTPException, Response, status, Depends
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from pydantic import BaseModel
from tortoise.exceptions import DoesNotExist
from tortoise.contrib.fastapi import register_tortoise
from tortoise.contrib.pydantic import pydantic_model_creator

# internal modules
from internal.database import UserModel

# logger module
log = logging.getLogger(__name__)

# main application instance
app = FastAPI()

# secret code, this is autogenerated
_JWT_SECRET = "v7hPzbPawtFcszHA4n9d"

# connect to the database
# create a database if does not exist
register_tortoise(
    app,
    db_url="sqlite://db.sqlite3",
    modules={"models": ["internal.database"]},
    generate_schemas=True,
)

# user(pydantic dataclass) schema from usermodel
UserSchema = pydantic_model_creator(UserModel, name="User", exclude_readonly=True)
# oauth authentication scheme
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")


@app.get("/")
def index() -> Dict[str, str]:
    return {"hello": "world"}


async def get_authenticated_user(username: str, password: str) -> UserModel:
    user = await UserModel.get(username=username)
    if not user:
        return None
    if not user.verify_password(password):
        return None
    return user


@app.post("/token", status_code=status.HTTP_200_OK)
async def generate_token(form_data: OAuth2PasswordRequestForm = Depends(), response: Response=Response()):
    try:
        user_model = await get_authenticated_user(form_data.username, form_data.password)
    except DoesNotExist:
        response.status_code = status.HTTP_401_UNAUTHORIZED
        return {"error": f"account does not exist"}
    else:
        if user_model:
            user = await UserSchema.from_tortoise_orm(user_model)
            token = jwt.encode(user.model_dump(), _JWT_SECRET)
            return {"access_token": token, "token_type": "bearer"}
        else:
            response.status_code = status.HTTP_401_UNAUTHORIZED
            return {"error": "invalid credentials"}

async def get_current_user(token: str = Depends(oauth2_scheme)):
    # as long as there is an oauth2 scheme in the
    # dependency chain, that would be locked in
    # to the login user dependency
    try:
        payload = jwt.decode(token, _JWT_SECRET, algorithms='HS256')
        user = await UserModel.get(id=payload.get('id'))
    except:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid username or password")
    return await UserModel.from_tortoise_orm(user)

@app.post("/users", response_model=UserSchema)
def login(user: UserSchema = Depends(get_current_user)) -> Any:
    return user

@app.post("/signup", response_model=UserSchema)
async def signup(user: UserSchema) -> Any:
    user = UserModel(
        username=user.username, password_hash=bcrypt.hash(user.password_hash)
    )
    await user.save()
    return await UserSchema.from_tortoise_orm(user)
