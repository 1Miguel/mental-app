"""schema.py

This module contains all REST API schema. The schema
uses pydantic base model.

date: 10/07/2023
"""
from typing import List, Tuple, Dict
from pydantic import BaseModel, Field
from internal.database import MembershipType, MembershipStatus, AppointmentStatus


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


class AppointmentApi(BaseModel):
    """API model of appointment.

    Supported Method: POST
    """

    id: int
    patient: int
    center: str
    start_time: str
    end_time: str
    status: AppointmentStatus


class AppointmentBlockedSlot(BaseModel):
    start_time: str
    end_time: str


class AppointmentApi(BaseModel):
    """API model for appointment booking.

    Supported Method: POST
    """

    start_time: str
    end_time: str


class UserApi(BaseModel):
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
    birthday: str = ""
    address: str = ""
    age: int = 0
    occupation: str = ""
    mobile_number: str = ""
    membership_type: MembershipType = MembershipType.NONE
    membership_status: MembershipStatus = MembershipStatus.NULL


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
    thread_id: int
    topic: str
    content: str
    creator: str = ""
    date_created: str = ""
    comments: List[ThreadCommentApi] = Field(default_factory=list)
