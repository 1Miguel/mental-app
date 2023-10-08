"""schema.py

This module contains all REST API schema. The schema
uses pydantic base model.

date: 10/07/2023
"""
from typing import List, Dict, Tuple
from pydantic import BaseModel
from internal.database import MembershipType


class MoodLog(BaseModel):
    """Daily mood API schema.
    Method: POST
    """

    mood: int


class UserApi(BaseModel):
    """API model of a users."""

    email: str
    password: str
    firstname: str = ""
    lastname: str = ""


class UserProfileApi(BaseModel):
    """API model to change a user profile"""

    id: int = 0
    email: str = ""
    firstname: str = ""
    lastname: str = ""
    birthday: str = ""
    address: str = ""
    age: int = 0
    occupation: str = ""
    membership_type: MembershipType = MembershipType.NONE


class MembershipApi(BaseModel):
    """API model of a membership post."""

    membership_type: MembershipType


class ScheduleApi(BaseModel):
    """API model of a schedule."""

    # datetime in iso format
    datetime: str
    # TODO: for now we only use one center,
    # we reserve this in case we have more center.
    center: str = ""


class ScheduleTime(BaseModel):
    time: str
    available: bool


class ScheduleAvailable(BaseModel):
    date: str
    time: List[ScheduleTime]


class ScheduleListApi(BaseModel):
    date_list: List[ScheduleAvailable]
