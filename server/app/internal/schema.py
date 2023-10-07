"""schema.py

This module contains all REST API schema. The schema
uses pydantic base model.

date: 10/07/2023
"""
from typing import Optional
from pydantic import BaseModel
from database import MembershipType


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

    firstname: str = ""
    lastname: str = ""
    birthday: str = ""
    address: str = ""
    age: int = 0
    occupation: str = ""


class MembershipApi(BaseModel):
    """API model of a membership post."""

    membership_type: MembershipType
