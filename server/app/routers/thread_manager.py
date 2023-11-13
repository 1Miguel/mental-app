# ---- Standard
import logging
from typing import List, Optional, Any
from datetime import datetime

# ---- Thirdparty
from fastapi import HTTPException, status, Depends, Path
from fastapi.routing import APIRouter
from tortoise.exceptions import DoesNotExist

# ---- Locals
from routers.account import get_current_user
from internal.database import *
from internal.schema import *

# internal modules
from internal.database import *
from internal.schema import *

# logger module
log = logging.getLogger(__name__)


class ThreadManager:
    def __init__(self, router: Optional[APIRouter] = None, log: Optional[logging.Logger] = None) -> None:
        self._log = log if log else logging.getLogger(__name__)
        self._routing = router if router else APIRouter()

        # ---- DELETE methods
        self._routing.add_api_route(
            "/user/thread/{thread_id}/",
            self.thread_delete,
            methods=["DELETE"],
        )
        # ---- POST methods
        self._routing.add_api_route(
            "/user/thread/submit",
            self.thread_submit,
            methods=["POST"],
        )
        self._routing.add_api_route(
            "/user/thread/{thread_id}/comment/",
            self.thread_comment,
            methods=["POST"],
        )
        self._routing.add_api_route(
            "/user/thread/{thread_id}/like/",
            self.thread_like,
            methods=["POST"],
        )
        # ---- GET methods
        self._routing.add_api_route(
            "/user/thread/{thread_id}/",
            self.get_thread,
            methods=["GET"],
            response_model=ThreadRequestApi,
        )
        self._routing.add_api_route(
            "/user/thread/query/",
            self.get_all_thread_with_filter,
            methods=["GET"],
        )
        self._routing.add_api_route(
            "/user/thread/page/{page}/",
            self.get_thread_list,
            methods=["GET"],
            response_model=List[ThreadRequestApi],
        )

    @property
    def router(self) -> APIRouter:
        """FastAPI Router Instance.

        Returns:
            APIRouter: This class api router.
        """
        return self._routing

    async def thread_submit(self, thread_request: ThreadRequestApi, user: UserProfileApi = Depends(get_current_user)) -> Any:
        """User create and submits a new thread."""
        await ThreadModel(
            user=await UserModel.get(email=user.email),
            creator=thread_request.creator,
            topic=thread_request.topic,
            content=thread_request.content,
        ).save()

    async def thread_delete(self, thread_id: int, user: UserProfileApi = Depends(get_current_user)) -> Any:
        try:
            thread_db = await ThreadModel.get(id=thread_id)
        except DoesNotExist as exc:
            raise HTTPException(status.HTTP_404_NOT_FOUND, detail="Thread not found or does not exist") from exc
        thread_creator: UserModel = await thread_db.user
        if thread_creator.id != user.id:
            raise HTTPException(
                status.HTTP_401_UNAUTHORIZED,
                detail="attempting to delete a thread not created by the User.",
            )
        await thread_db.delete()

    async def thread_comment(
        self,
        thread_id: int,
        thread_comment: ThreadCommentApi,
        user: UserProfileApi = Depends(get_current_user),
    ) -> Any:
        """A User comment to a thread"""
        try:
            thread: ThreadModel = await ThreadModel.get(id=thread_id)
            commenter = await UserModel.get(email=user.email)
            await ThreadCommentModel(user=commenter, thread=thread, content=thread_comment.content).save()
            thread.num_comments += 1
            await thread.save()
        except DoesNotExist as exc:
            raise HTTPException(status.HTTP_404_NOT_FOUND, detail="Thread not found or does not exist") from exc

    async def thread_like(
        self,
        thread_id: int,
        thread_like_api: ThreadLikeApi,
        user: UserProfileApi = Depends(get_current_user),
    ) -> Any:
        user_db = await UserModel.get(email=user.email)
        try:
            thread_db = await ThreadModel.get(id=thread_id)
        except DoesNotExist as exc:
            raise HTTPException(status.HTTP_404_NOT_FOUND, detail="Thread not found or does not exist") from exc
        else:
            thread_like_db = await ThreadUserLikeModel.filter(user__id=user_db.id, thread__id=thread_id)

            if thread_like_db and not thread_like_api.like:
                # if the like is in the database, this means user already like the thread
                # to unlike, delete the like item in the database.
                await thread_like_db[0].delete()
                # decrement thread likes
                thread_db.num_likes -= 1
                # then save
                await thread_db.save()

            elif not thread_like_db and thread_like_api.like:
                # thread is not yet liked by the user check if the API instruct
                # us to like this thread - create a new model
                await ThreadUserLikeModel(user=user_db, thread=thread_db).save()
                # add thread like count
                thread_db.num_likes += 1
                # then save
                await thread_db.save()

    async def get_thread(self, thread_id: int, user: UserProfileApi = Depends(get_current_user)) -> ThreadRequestApi:
        """A User comment to a thread"""
        try:
            thread: ThreadModel = await ThreadModel.get(id=thread_id)
        except DoesNotExist as exc:
            raise HTTPException(status.HTTP_404_NOT_FOUND, detail="Thread not found or does not exist") from exc
        # create the response model
        response: ThreadRequestApi = await ThreadRequestApi.from_model(thread)
        # build the list of responses
        for comment in await ThreadCommentModel.get_thread_comments(thread_id):
            response.comments += [
                ThreadCommentApi(
                    creator=(await comment.user).email,
                    date_created=comment.created.isoformat(),
                    content=comment.content,
                )
            ]
        return response

    async def get_thread_list(
        self, page: int = 0, limit: int = 5, user: UserProfileApi = Depends(get_current_user)
    ) -> List[ThreadRequestApi]:
        """Get thread list base on page."""
        user_db = await UserModel.get(email=user.email)
        thread_list = await ThreadModel.all().order_by("-created").offset(page * 5).limit(limit)
        thread_req = []
        for thread in thread_list:
            _th = await ThreadRequestApi.from_model(thread)
            _th.is_liked = await ThreadUserLikeModel.exists(user__id=user.id, thread__id=thread.id)
            thread_req.append(_th)
        return thread_req

    async def get_all_thread_with_filter(
        self, filter: str, limit: int = 100, user: UserProfileApi = Depends(get_current_user)
    ) -> List[ThreadRequestApi]:
        if filter == "liked":
            thread = [
                await ThreadRequestApi.from_model(await liked_thread.thread)
                for liked_thread in await ThreadUserLikeModel.filter(user__id=user.id).order_by("-liked_at").limit(limit)
            ]
        elif filter == "posted":
            thread = [
                await ThreadRequestApi.from_model(thread)
                for thread in await ThreadModel.filter(user__id=user.id).order_by("-created").limit(limit)
            ]
        else:
            raise HTTPException(status.HTTP_400_BAD_REQUEST, detail=f"invalid filter {filter}")
        return thread
