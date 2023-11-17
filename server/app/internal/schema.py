"""schema.py

This module contains all REST API schema. The schema
uses pydantic base model.

date: 10/07/2023
"""
from typing import List, Tuple, Dict
from datetime import datetime
from pydantic import BaseModel, Field
from internal.database import (
    UserModel,
    MembershipType,
    MembershipStatus,
    AppointmentStatus,
    AppointmentServices,
    AppointmentModel,
    ThreadModel,
    ThreadUserLikeModel,
)


class MoodLog(BaseModel):
    """Daily mood API schema.
    Supported Method: POST
    """

    mood: int
    note: str = ""
    date: str = ""  # date in isoformat


class MoodListResponse(BaseModel):
    """Mood list data model, a datastructure returned
    when list of mood logs in a given month is requested.

    Supported Method: GET
    """

    percentages: List[int]
    mood_list: List[MoodLog]


class AppointmentInfoApi(BaseModel):
    """API model of appointment.

    Supported Method: POST
    """

    id: int
    patient_id: int
    patient_name: str
    center: str
    start_time: datetime
    end_time: datetime
    status: AppointmentStatus
    service: AppointmentServices
    concerns: str

    @classmethod
    async def from_model(cls, model: AppointmentModel) -> "AppointmentInfoApi":
        patient: UserModel = await model.patient
        return cls(
            id=model.id,
            patient_id=patient.id,
            patient_name=patient.fullname,
            center="",
            start_time=model.start_time,
            end_time=model.end_time,
            status=model.status,
            service=model.service,
            concerns=model.concerns,
        )


class AppointmentBlockedSlot(BaseModel):
    start_time: datetime
    end_time: datetime

    @classmethod
    async def from_model(cls, model: AppointmentModel) -> "AppointmentBlockedSlot":
        return cls(
            start_time=model.start_time,
            end_time=model.end_time,
        )


class AppointmentUpdateStatusApi(BaseModel):
    status: AppointmentStatus


class AppointmentApi(BaseModel):
    """API model for appointment booking.

    Supported Method: POST
    """

    start_time: datetime
    end_time: datetime
    service: AppointmentServices
    concerns: str = ""


class UserSignUpApi(BaseModel):
    """API model of a users.

    Supported Method: POST
    """

    email: str
    password: str
    firstname: str
    lastname: str


class UserProfileApi(BaseModel):
    """API model to change a user profile

    Supported Method: POST, GET
    """

    id: int = 0
    email: str = ""
    firstname: str = ""
    lastname: str = ""
    username: str = ""
    birthday: str = ""
    address: str = ""
    age: int = 0
    occupation: str = ""
    mobile_number: str = ""
    membership_type: MembershipType = MembershipType.NONE
    membership_status: MembershipStatus = MembershipStatus.NULL
    created: str = ""
    is_admin: bool = False
    is_super: bool = False
    status: str = ""

    @classmethod
    def from_model(cls, model: UserModel) -> "UserProfileApi":
        return cls(
            id=model.id,
            email=model.email,
            firstname=model.firstname,
            lastname=model.lastname,
            username=model.username,
            birthday=model.birthday,
            address=model.address,
            age=model.age,
            occupation=model.occupation,
            mobile_number=model.mobile_number,
            created=model.created.isoformat(),
        )


class UserSettingsApi(BaseModel):
    local_notif: bool = False


class MembershipRegisterApi(BaseModel):
    """API model of a user membership.

    Supported Method: POST
    """

    membership_type: MembershipType


class MembershipCancelApi(BaseModel):
    """API model of a user membership cancellation.

    Supported Method: POST
    """

    reason: str
    suggestion: str


class MembershipProfileApi(BaseModel):
    """API model for accessing membership profile

    Supported Method: GET
    """

    id: int
    user: int
    firstname: str
    lastname: str
    email: str
    type: str
    status: str


class MembershipSetStatusApi(BaseModel):
    status: str


class ThreadCommentApi(BaseModel):
    """API model for posting a comment to a thread.

    Supported Method: POST
    """

    creator: str = ""
    date_created: str = ""
    content: str


class ThreadRequestApi(BaseModel):
    topic: str
    content: str
    thread_id: int = 0
    creator: str = ""
    date_created: datetime = datetime.today()
    is_liked: bool = False
    num_likes: int = 0
    num_comments: int = 0
    comments: List[ThreadCommentApi] = Field(default_factory=list)

    @classmethod
    async def from_model(cls, user: UserModel, model: ThreadModel) -> "ThreadRequestApi":
        return cls(
            thread_id=model.id,
            topic=model.topic,
            content=model.content,
            creator=model.creator,
            num_likes=model.num_likes,
            num_comments=model.num_comments,
            date_created=model.created,
            is_liked=await ThreadUserLikeModel.exists(user=user, thread=model),
        )


class ThreadLikeApi(BaseModel):
    """Thread like REST API.
    If like is set to True, this means like, else unlike.
    """

    like: bool


class AdminStatsApi(BaseModel):
    num_patients: int
    num_appointments_req: int
    num_todays_sessions: int
    services_percentages: Dict[AppointmentServices, float]


class PasswordChangeReqApi(BaseModel):
    new_password: str = Field(..., min_length=8)


class ForgotPasswordChangeReqApi(BaseModel):
    new_password: str = Field(..., min_length=8)
    user_email: str

class ArchiveFilterApi:
    id: int = 0
    user_id: int = 0
    email: str = ""