"""Account management.

Contains all routes and routines that manages all account related services.

date: 02/11/2023
"""
import logging
from pathlib import Path
from tempfile import TemporaryDirectory
from datetime import datetime
from typing import Any, Optional

# third-party imports
import jwt
from passlib.hash import bcrypt
from fastapi import HTTPException, Response, status, Depends, APIRouter, Header
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from fastapi.responses import RedirectResponse
from tortoise.exceptions import DoesNotExist, IntegrityError
from tortoise.contrib.pydantic import pydantic_model_creator

# internal modules
from routers.notify import NotificationSchema, Notifier
from internal.database import *
from internal.schema import *

# ------------------------------------------------------ #
# Debug
# ------------------------------------------------------ #
# logger module
log = logging.getLogger(__name__)

# ------------------------------------------------------ #
# Globals
# ------------------------------------------------------ #
# secret code, this is random and autogenerated
_JWT_SECRET = "v7hPzbPawtFcszHA4n9d"
# user(pydantic dataclass) schema from usermodel
UserSchema = pydantic_model_creator(UserModel, name="User", exclude_readonly=False)
# oauth authentication scheme
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")


def _generate_default_username() -> None:
    return "user_" + "".join([str(i) for i in bcrypt.hash(datetime.now().isoformat().encode()).encode()[-3::]])


async def _get_authenticated_user(
    token: str, *, check_admin: bool = False, check_super: bool = False
) -> UserProfileApi:
    """Returns the user database model from given token. This is the validation
    routine when a user attempts to access a page that requries authentication
    via token.

    When check_admin is set to True, authentication would require to validate if
    the token credential is an admin account. If not, would raise an 401 Error.

    Args:
        token (str, optional): User Token. Defaults to Depends(oauth2_scheme).

    Raises:
        HTTPException: HTTP_401_UNAUTHORIZED for invalid access.
    """
    if await JwtBlacklist.exists(token=token):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid email or password",
        )
    try:
        # ---- check if this email has valid auth
        user: UserModel = await UserModel.get(email=jwt.decode(token, _JWT_SECRET, algorithms="HS256").get("email"))
    except:
        # ---- account invalid or user does not exist
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid email or password",
        )
    # ---- check if this is a banned account
    # if await  BannedUsersModel.exists(user=user, status=True):
    #     raise HTTPException(
    #         status_code=status.HTTP_401_UNAUTHORIZED,
    #         detail="This user is banned.",
    #     )
    profile = UserProfileApi.from_model(user)
    if await BannedUsersModel.exists(user=user, status=True):
        profile.status = "BANNED"

    # ---- check if this account is an admin
    profile.is_admin = False
    try:
        admin = await AdminModel.get(admin_user=user)
    except DoesNotExist as exc:
        if check_admin or check_super:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="User attempts to login with invalid admin account.",
            )
    else:
        profile.is_admin = True
        if check_super and not admin.is_super:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="User attempts to login with invalid super admin account.",
            )
        else:
            profile.is_super = admin.is_super

    # ---- return account json profile
    # TODO: should I just return the actual database item?
    return profile


async def get_current_user(token: str = Depends(oauth2_scheme)) -> UserProfileApi:
    """Returns the user database model from given token. This is the validation
    routine when a user attempts to access a page that requries authentication
    via token.

    Args:
        token (str, optional): User Token. Defaults to Depends(oauth2_scheme).

    Raises:
        HTTPException: HTTP_401_UNAUTHORIZED for invalid access.
    """
    return await _get_authenticated_user(token)


async def get_admin_user(token: str = Depends(oauth2_scheme)) -> UserProfileApi:
    return await _get_authenticated_user(token, check_admin=True)


async def get_super_admin_user(token: str = Depends(oauth2_scheme)) -> UserProfileApi:
    return await _get_authenticated_user(token, check_admin=True, check_super=True)


class AccountManager:
    # temporary file where all files will be stored
    _temp_file_storage: TemporaryDirectory = "./files"

    def __init__(self, router: Optional[APIRouter] = None, log: Optional[logging.Logger] = None) -> None:
        self._log = log if log else logging.getLogger(__name__)
        self._routing = router if router else APIRouter()
        #: ---- Set all routes
        self._routing.add_api_route("/login",
            self.login,
            methods=["GET"],
            response_model=UserProfileApi
        )
        self._routing.add_api_route(
            "/signup",
            self.signup,
            methods=["POST"],
        )
        self._routing.add_api_route("/token",
            self._generate_token,
            methods=["POST"],
            response_model=Any
        )
        self._routing.add_api_route("/user/updatesettings",
            self.update_settings,
            methods=["POST"]
        )
        self._routing.add_api_route("/user/updateprofile",
            self.update_profile,
            methods=["POST"]
        )
        self._routing.add_api_route("/users",
            self.get_all_users,
            methods=["GET"],
            response_model=List[str]
        )
        self._routing.add_api_route("/user/changepassword",
            self.change_password,
            methods=["POST"]
        )
        self._routing.add_api_route("/user/forgotpassword",
            self.forgot_change_password,
            methods=["POST"]
        )
        self._routing.add_api_route(
            "/user/notification/{notif_id}",
            self.get_notification,
            methods=["GET"],
            response_model=NotificationSchema,
        )
        self._routing.add_api_route(
            "/user/notification/",
            self.get_all_notificaton,
            methods=["GET"],
            response_model=List[NotificationSchema],
        )
        self._routing.add_api_route(
            "/user/notification/unread/",
            self.get_unread_notificaton,
            methods=["GET"],
            response_model=int,
        )

    @property
    def router(self) -> APIRouter:
        """FastAPI Router Instance.

        Returns:
            APIRouter: This class api router.
        """
        return self._routing

    async def index(self) -> None:
        pass

    async def _get_authenticated_user(self, email: str, password: str) -> UserModel:
        """Returns the authenticated user database model if the given
        credentials are correct, else this will return None.
        """
        user = await UserModel.get(email=email)
        if not user:
            return None
        if not user.verify_password(password):
            return None
        return user

    async def _generate_token(
        self,
        form_data: OAuth2PasswordRequestForm = Depends(),
        response: Response = Response(),
    ) -> Any:
        """Generates a session token."""
        try:
            user_model = await self._get_authenticated_user(form_data.username, form_data.password)
        except DoesNotExist:
            response.status_code = status.HTTP_401_UNAUTHORIZED
            return {"error": f"account does not exist"}
        else:
            if user_model:
                user = UserProfileApi.from_model(user_model)
                token = jwt.encode(user.model_dump(), _JWT_SECRET)
                return {"access_token": token, "token_type": "bearer"}
            else:
                response.status_code = status.HTTP_401_UNAUTHORIZED
                return {"error": "invalid credentials"}

    async def login(self, user: UserProfileApi = Depends(get_current_user)) -> UserProfileApi:
        """login route called when user wants to login. This depends on the user
        if the user has a token. If the user does not have a valid token, reject
        the login request.
        """
        self._log.info("A user %s log in...", user)
        # return the profile at login success
        return user

    async def signup(self, user: UserSignUpApi) -> None:
        """Route to call when user wishes to create a new account.
        This requires unique credential. if email or email is already used,
        reject the signup request.
        """
        log.info("Create user %s", user)
        try:
            user: UserModel = UserModel(
                email=user.email,
                password_hash=bcrypt.hash(user.password),
                firstname=user.firstname,
                lastname=user.lastname,
                username=_generate_default_username(),
                birthday=datetime(year=1900, month=1, day=1).isoformat(),
            )
            await user.save()
            # create a folder space for the user, this will serve as
            # file storage path where all files user uploads will be stored.
            # Path(self._temp_file_storage.name).joinpath(str(user.id)).mkdir(exist_ok=True)
            # create a default user settings
            await UserSettingModel(user=user).save()
            log.info("New user profile %s", UserProfileApi.from_model(user))
        except IntegrityError as err:
            log.critical("Attempt to create user that already exist.")
            raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail="email is already used.") from err

    async def update_profile(
        self,
        profile: UserProfileApi,
        user: UserProfileApi = Depends(get_current_user),
    ) -> Any:
        """Update user profile route."""
        user_model = await UserModel.get(email=user.email)
        # update only when field exist
        # TODO: there must some way to do this efficiently
        self._log.info("new profile request %s", profile)
        if profile.address:
            user_model.address = profile.address
        if profile.birthday:
            user_model.birthday = profile.birthday
        if profile.firstname:
            user_model.firstname = profile.firstname
        if profile.lastname:
            user_model.lastname = profile.lastname
        if profile.occupation:
            user_model.occupation = profile.occupation
        if profile.address:
            user_model.address = profile.address
        if profile.username:
            self._log.info("setting username %s", profile.username)
            user_model.username = profile.username
        await user_model.save()
        return UserProfileApi.from_model(user_model)

    async def update_settings(
        self,
        user_settings: UserSettingsApi,
        user: UserProfileApi = Depends(get_current_user),
    ):
        settings = UserSettingModel.get(user=await UserSettingModel.get(id=user.id))
        settings.local_notif = user_settings.local_notif
        settings.save()

    async def get_all_users(self, user: UserProfileApi = Depends(get_current_user)) -> List[str]:
        return [user.username for user in await UserModel.all() if user.username]

    async def change_password(
        self,
        new_password: PasswordChangeReqApi,
        user: UserProfileApi = Depends(get_current_user),
    ) -> None:
        await self._internal_change_password(new_password, user)

    async def forgot_change_password(self, new_password: ForgotPasswordChangeReqApi) -> None:
        try:
            user = UserProfileApi.from_model(await UserModel.get_user(new_password.user_email))
            # TODO: Refactor this
            await self._internal_change_password(PasswordChangeReqApi(new_password=new_password.new_password), user)
        except DoesNotExist:
            raise HTTPException(status.HTTP_400_BAD_REQUEST, detail="User email invalid.")

    async def _internal_change_password(self, new_password: PasswordChangeReqApi, user: UserProfileApi) -> None:
        """Updates the user's password request.

        Args:
            new_password (PasswordChangeReqApi): New Password Request dataclass.
            user (UserProfileApi): User Profile dataclass.
        """
        user: UserModel = await UserModel.get(id=user.id)
        old_token = jwt.encode(UserProfileApi.from_model(user).model_dump(), _JWT_SECRET)
        old_password_hash = user.password_hash

        # ---- validate if this password is old
        for old_pw in await UserPasswordHistoryModel.filter(user=user):
            is_old = bcrypt.verify(new_password.new_password, old_pw.password_hash)
            self._log.critical("validating password %s...", is_old)
            if is_old:
                raise HTTPException(status.HTTP_400_BAD_REQUEST, "Dont use old password.")
        # ---- 1. update the password hash and save new model
        self._log.critical("Saving new password...")
        user.password_hash = bcrypt.hash(new_password.new_password)
        await user.save()
        # ---- 2. remember old hash
        self._log.critical("Blacklisting password...")
        await UserPasswordHistoryModel(user=user, password_hash=old_password_hash).save()
        # ---- 3. Blacklist the token
        self._log.critical("Blacklisting token...")
        await JwtBlacklist(token=old_token).save()

    def user_logout(Authorization: str = Header(None)):
        pass

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
            notif_data: NotificationMessageModel = await NotificationMessageModel.get(user__id=user.id, id=notif_id)
            if not notif_data.is_read:
                notif_data.is_read = True
                notif_data.read = datetime.now()
                await notif_data.save()
        except DoesNotExist:
            raise HTTPException(status.HTTP_404_NOT_FOUND, detail="Notificaton not found.")
        return await NotificationSchema.from_tortoise_orm(notif_data)

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

    async def get_unread_notificaton(self) -> int:
        """Returns the count of threads pending to be read."""
        return await NotificationMessageModel.filter(is_read=False).count()