import sys
import logging
from pathlib import Path
from tempfile import TemporaryDirectory
from datetime import datetime
from typing import Dict, Any, Optional, Annotated

# third-party imports
import jwt
from passlib.hash import bcrypt
from fastapi import FastAPI, HTTPException, Response, status, Depends, File, Form, UploadFile
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
# TODO: Add a flag if logging must be displayed in the terminal
#       flag can either be an env variable or from a file.
#       another option is for this to be in the unit test file.
log.setLevel(logging.DEBUG)
handler = logging.StreamHandler(sys.stdout)
handler.setLevel(logging.DEBUG)
handler.setFormatter(logging.Formatter("%(levelname)s: %(asctime)-15s : %(message)s"))
log.addHandler(handler)

# main application instance
app = FastAPI()

origins = ["*"]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# temporary file close on shutdown
_TEMP_FILE_DEL_ON_SHUTDOWN = True

# secret code, this is random and autogenerated
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
UserSchema = pydantic_model_creator(UserModel, name="User", exclude_readonly=False)
UserSchemaReadOnly = pydantic_model_creator(UserModel, name="User", exclude_readonly=True)
# oauth authentication scheme
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")
# temporary file where all files will be stored
temp_file_storage: TemporaryDirectory = None

@app.on_event("startup")
async def startup() -> None:
    """Routine at application startup."""
    global temp_file_storage
    log.info("Startup routine")
    temp_file_storage = TemporaryDirectory(dir=".") 


@app.on_event("shutdown")
async def shutdown() -> None:
    """Route at application shutdown"""
    log.info("Shutdown routine")
    if _TEMP_FILE_DEL_ON_SHUTDOWN:
        temp_file_storage.cleanup()


@app.get("/")
def index() -> Dict[str, str]:
    """Index route.
    TODO: Implement the right routine"""
    return {"message": "Hello World"}


async def get_authenticated_user(email: str, password: str) -> UserModel:
    """Returns the authenticated user database model if the given
    credentials are correct, else this will return None.
    """
    user = await UserModel.get(email=email)
    if not user:
        return None
    if not user.verify_password(password):
        return None
    return user


async def get_current_user(token: str = Depends(oauth2_scheme)) -> Any:
    # as long as there is an oauth2 scheme in the
    # dependency chain, that would be locked in
    # to the login user dependency
    try:
        payload = jwt.decode(token, _JWT_SECRET, algorithms="HS256")
        user = await UserModel.get(email=payload.get("email"))
    except:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid email or password",
        )
    return await UserSchema.from_tortoise_orm(user)


@app.post("/token", status_code=status.HTTP_200_OK)
async def generate_token(
    form_data: OAuth2PasswordRequestForm = Depends(), response: Response = Response()
) -> Any:
    """Generates a session token."""
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


@app.get("/login", response_model=UserProfileApi)
async def login(user: UserSchema = Depends(get_current_user)) -> Any:
    """login route called when user wants to login. This depends on the user
    if the user has a token. If the user does not have a valid token, reject
    the login request.
    """
    # return the profile at login success
    return UserProfileApi(
        id=user.id,
        email=user.email,
        firstname=user.firstname,
        lastname=user.lastname,
        address=user.address,
        age=user.age,
        occupation=user.occupation,
        birthday=user.birthday,
        membership_type=MembershipType.NONE,
    )


@app.post("/user/mood")
async def mood_log(mood: MoodLog, user: UserSchema = Depends(get_current_user)) -> None:
    """Daily Mood Logging. if mood score has been log for today, dont lot anymore
    and return an HTTP_409_CONFLICT error."""
    user = await UserModel.get(email=user.email)
    today = datetime.today().date()
    try:
        mood_id = MoodId(mood.mood)
        mood_db = await MoodModel.get(date=datetime.today().date())
        mood_db.mood = mood_id
        mood_db.note = mood.note
    except DoesNotExist:  # no data log today, create a new data to save
        mood_db = MoodModel(user=user, mood=mood_id, date=today, note=mood.note)
    except ValueError:  # invalid mood id
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Invalid Data.")
    await mood_db.save()


@app.get("/user/mood/", response_model=MoodListResponse)
async def mood_get(month: str, user: UserSchema = Depends(get_current_user)) -> MoodListResponse:
    """This handles the mood log request. This will return a response that contains
    list of all moods log in a given month."""
    try:
        month = datetime.fromisoformat(month)
        response = MoodListResponse(mood_list=[])
        for mood_db_data in await MoodModel.get_all_by_month(user.email, month):
            response.mood_list += [
                MoodLog(
                    mood=mood_db_data.id, note=mood_db_data.note, date=mood_db_data.date.isoformat()
                )
            ]
        return response
    except ValueError as exc:  # wrong datetime isoformat
        log.error("Receive Invalid Month %s", month)
        raise HTTPException(
            status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
            detail=f"given month {month} is not a valid isoformat",
        ) from exc


@app.post("/user/membership/register")
async def membership_register_route(
    membership_api: str = Form(...),
    files: List[UploadFile] = File(...),
    user: UserSchema = Depends(get_current_user),
) -> Any:
    """New Membership Request."""
    try:
        # the api field is not a json field but raw string, parse...
        membership_api: MembershipRegisterApi = MembershipRegisterApi.model_validate_json(membership_api)
        if not files:
            # no files attached
            raise HTTPException(
                status.HTTP_400_BAD_REQUEST, detail="Failed to attach files."
            )
        user_model = await UserModel.get(email=user.email)
        for file in files:
            p = Path(temp_file_storage.name).joinpath(str(user_model.id))
            # NOTE: this is temporary, the file storage space must be
            # created when user creates a new account/profile... unless
            # we expect user files to be deleted on runtime by the admin
            if not p.is_dir():
                p.mkdir(exist_ok=True)
            p.joinpath(file.filename).write_bytes(await file.read())
        # create a new membership request
        new_membership_req = MembershipModel(
            user = user_model,
            type = membership_api.membership_type,
            status = MembershipStatus.PENDING, 
        )
        await new_membership_req.save()
    except ValidationError as exc:
        raise HTTPException(
            status.HTTP_422_UNPROCESSABLE_ENTITY, jsonable_encoder(exc.errors())
        ) from exc


@app.post("/user/membership/cancel")
async def membership_cancel_route(
    membership: MembershipCancelApi, user: UserSchema = Depends(get_current_user)
) -> None:
    """User cancels its membership route."""
    user_model = await UserModel.get(email=user.email)
    # check first if membership exists for this user
    membership_profile: MembershipModel = MembershipModel.get(user=user_model)
    if membership_profile is None:
        raise HTTPException(
            status.HTTP_404_NOT_FOUND, detail="Membership profile not found."
        )
    if membership_profile.status in (MembershipStatus.ACTIVE, MembershipStatus.PENDING, MembershipStatus.EXPIRED):
        # only cancel membership that are either
        # currently active, expired or pending to be approved
        membership_profile.status = MembershipStatus.CANCELLED
        membership_profile.cancel_reason = membership.reason
        membership_profile.cancel_suggestion = membership.suggestion
        await membership_profile.save()


@app.post("/signup")
async def signup_route(user: UserApi) -> Any:
    """Route to call when user wishes to create a new account.
    This requires unique credential. if email or email is already used,
    reject the signup request.
    """
    log.info("Create user %s", user)
    try:
        user = UserModel(
            email=user.email,
            password_hash=bcrypt.hash(user.password),
            firstname=user.firstname,
            lastname=user.lastname,
            address="",
            age=0,
            occupation="",
            birthday=datetime(year=1900, month=1, day=1).isoformat(),
        )
        await user.save()
        # create a folder space for the user, this will serve as 
        # file storage path where all files user uploads will be stored.
        Path(temp_file_storage.name).joinpath(str(user.id)).mkdir(exist_ok=True)
    except IntegrityError as err:
        log.critical("Attempt to create user that already exist.")
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT, detail="email is already used."
        ) from err


@app.post("/user/updateprofile")
async def update_profile(
    profile: UserProfileApi,
    user: UserSchema = Depends(get_current_user),
) -> Any:
    """Update user profile route."""
    user_model = await UserModel.get(email=user.email)
    # update only when field exist
    # TODO: there must some way to do this efficiently
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
    await user_model.save()

@app.get("user/appointments")
async def get_appointment_list(
    user: UserSchema = Depends(get_current_user)
) -> List[AppointmentAvailSlot]:
    filter = ""
    filter_key, filter_val = filter.split(",")
    if filter_key != "month":
        pass
    try:
        month_filter = datetime.fromisoformat(filter_val)
        return [
            AppointmentAvailSlot(time="", available=True)
        ]
    except ValueError:
        #invalid filter value, expect iso format month
        raise HTTPException(status.HTTP_400_BAD_REQUEST, f"Invalid param {filter_key}, expected Iso")

def run() -> None:
    import uvicorn

    uvicorn.run(app, host="127.0.0.1", port=8000)


if __name__ == "__main__":
    run()
