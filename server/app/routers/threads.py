import sys
import logging
from pathlib import Path
from tempfile import TemporaryDirectory
from datetime import datetime
from typing import Dict, Any, Optional

# third-party imports
import jwt
from passlib.hash import bcrypt
from fastapi import (
    routing,
    FastAPI,
    HTTPException,
    Response,
    status,
    Depends,
    File,
    Form,
    UploadFile,
)
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from fastapi.middleware.cors import CORSMiddleware
from fastapi.encoders import jsonable_encoder
from tortoise.exceptions import DoesNotExist, IntegrityError
from tortoise.contrib.fastapi import register_tortoise
from tortoise.contrib.pydantic import pydantic_model_creator
from pydantic import ValidationError

# internal modules
from internal.database import *
from internal.schema import *

# logger module
log = logging.getLogger(__name__)

# fastapi router
router = routing.APIRouter()


@router.post("/user/thread/submit")
async def thread_submit(
    thread_request: ThreadRequestApi, user: UserProfileApi = Depends(get_current_user)
) -> Any:
    """User create and submits a new thread."""
    poster = await UserModel.get(email=user.email)
    await ThreadModel(
        user=poster, topic=thread_request.topic, content=thread_request.content
    ).save()


@router.delete("/user/thread/{thread_id}/")
async def thread_delete(
    thread_id: int, user: UserProfileApi = Depends(get_current_user_new)
) -> Any:
    try:
        thread_db = await ThreadModel.get(id=thread_id)
    except DoesNotExist as exc:
        raise HTTPException(
            status.HTTP_404_NOT_FOUND, detail="Thread not found or does not exist"
        ) from exc
    thread_creator: UserModel = await thread_db.user
    if thread_creator.id != user.id:
        raise HTTPException(
            status.HTTP_401_UNAUTHORIZED,
            detail="attempting to delete a thread not created by the User.",
        )
    await thread_db.delete()


@router.post("/user/thread/{thread_id}/comment/")
async def thread_comment(
    thread_id: int,
    thread_comment: ThreadCommentApi,
    user: UserSchema = Depends(get_current_user),
) -> Any:
    """A User comment to a thread"""
    try:
        thread: ThreadModel = await ThreadModel.get(id=thread_id)
        commenter = await UserModel.get(email=user.email)
        await ThreadCommentModel(
            user=commenter, thread=thread, content=thread_comment.content
        ).save()
    except DoesNotExist as exc:
        raise HTTPException(
            status.HTTP_404_NOT_FOUND, detail="Thread not found or does not exist"
        ) from exc


@router.post("/user/{thread_id}/like/")
async def thread_like(
    thread_id: int,
    thread_like_api: ThreadLikeApi,
    user: UserProfileApi = Depends(get_current_user_new),
) -> Any:
    user_db = await UserModel.get(email=user.email)
    try:
        thread_db = await ThreadModel.get(id=thread_id)
    except DoesNotExist as exc:
        raise HTTPException(
            status.HTTP_404_NOT_FOUND, detail="Thread not found or does not exist"
        ) from exc
    else:
        thread_like_db = await ThreadUserLikeModel.get_thread_like_by_user(user_db.id, thread_id)
        if thread_like_db and not thread_like_api.like:
            # if the like is in the database, this means user already like the thread
            # to unlike, delete the like item in the database.
            await thread_like_db[0].delete()
            # decrement thread likes
            thread_db.num_likes -= 1
            # then save
            await thread_db.save()

        elif thread_like_api.like:
            # thread is not yet liked by the user check if the API instruct
            # us to like this thread - create a new model
            await ThreadUserLikeModel(user=user_db, thread=thread_db).save()
            # add thread like count
            thread_db.num_likes += 1
            # then save
            await thread_db.save()


@router.get("/user/thread/{thread_id}")
async def get_thread(
    thread_id: int, user: UserSchema = Depends(get_current_user)
) -> ThreadRequestApi:
    """A User comment to a thread"""
    try:
        thread: ThreadModel = await ThreadModel.get(id=thread_id)
    except DoesNotExist as exc:
        raise HTTPException(
            status.HTTP_404_NOT_FOUND, detail="Thread not found or does not exist"
        ) from exc
    creator: UserModel = await thread.user
    # create the response model
    response = ThreadRequestApi(
        thread_id=thread_id,
        topic=thread.topic,
        content=thread.content,
        creator=creator.email,
        num_likes=thread.num_likes,
        date_created=thread.created.isoformat(),
    )
    # build the list of responses
    for comment in await ThreadCommentModel.get_thread_comments(thread_id):
        creator = await comment.user
        response.comments += [
            ThreadCommentApi(
                creator=creator.email,
                date_created=comment.created.isoformat(),
                content=comment.content,
            )
        ]

    # get all comments related to this thread
    return response


@router.get("/user/thread/{page}/")
async def get_thread_list(
    page: int = 0, limit: int = 5, user: UserSchema = Depends(get_current_user)
) -> List[ThreadRequestApi]:
    """Get thread list base on page."""
    thread_list = await ThreadModel.all().order_by("-created").offset(page * 5).limit(limit)
    thread_req = []
    for thread in thread_list:
        creator = await thread.user
        thread_req += [
            ThreadRequestApi(
                thread_id=thread.id,
                topic=thread.topic,
                content=thread.content,
                creator=creator.email,
                date_created=thread.created.isoformat(),
            )
        ]
    return thread_req
