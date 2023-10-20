"""schema.py

This module contains all REST API schema. The schema
uses pydantic base model.

date: 10/07/2023
"""
from typing import List, Tuple, Dict
from pydantic import BaseModel
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
    stop_time: str


class AppointmentListSlots(BaseModel):
    """API model of appointment slot. This is a user level model
    which only expose the necessary data to the user.
    [
        time: str
        slots: [
            (time, available)
        ]
    ]

    Supported Method: GET
    """
    slots: list[AppointmentBlockedSlot]


class AppointmentListResponse(BaseModel):
    """API model of appointment list query response.
    
    Supported Method: GET
    """

    appointment_list: List[AppointmentApi]


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
