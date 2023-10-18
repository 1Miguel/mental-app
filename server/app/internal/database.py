"""Database.py
This module contains all database schema models.

date: 10/07/2023
"""
from enum import IntEnum, Enum, auto
from datetime import datetime
from typing import List
from typing_extensions import Self
from passlib.hash import bcrypt
from tortoise.models import Model
from tortoise.fields import (
    DateField,
    IntEnumField,
    IntField,
    CharField,
    ForeignKeyField,
    CharEnumField,
)


class MoodId(IntEnum):
    """Mood Score Ids."""

    HAPPY = 0
    SAD = auto()
    CONFUSED = auto()
    SCARED = auto()
    ANGRY = auto()


class MembershipStatus(str, Enum):
    """Membership Status."""

    NULL = "NULL"
    PENDING = "PENDING"
    ACTIVE = "ACTIVE"
    EXPIRED = "EXPIRED"
    CANCELLED = "CANCELLED"
    REJECTED = "REJECTED"

class MembershipType(IntEnum):
    """Member Subscription Type Ids."""

    NONE = 0
    SUSTAINING = auto()
    CORPORATE = auto()
    CONTRIBUTING = auto()
    ASSOCIATE = auto()
    SENIOR_HS = auto()
    JUNIOR_HS = auto()


class UserModel(Model):
    """DataBase model of a users."""

    id = IntField(pk=True)
    email = CharField(128, unique=True)
    password_hash = CharField(128)
    firstname = CharField(128)
    lastname = CharField(128)
    address = CharField(256)
    age = IntField()
    occupation = CharField(128)
    birthday = CharField(128)

    @classmethod
    async def get_user(cls, email: str) -> Self:
        return cls.get(email=email)

    def verify_password(self, password) -> bool:
        return bcrypt.verify(password, self.password_hash)


class MoodModel(Model):
    """Mood model."""

    id = IntField(pk=True)
    user = ForeignKeyField("models.UserModel")
    mood = IntEnumField(MoodId)
    date = DateField()
    note = CharField(256)

    @classmethod
    async def get_all_by_month(cls, user_email: str, month: datetime) -> List[Self]:
        """Get all mood data filtered by month.

        Args:
            month (datetime): Month datetime filter.

        Returns:
            List[Self]: List of data filtered by month
        """
        # the month is in datetime isoformat YYYY-MM-DD to get only the
        # year and month, we need to cut the string
        return await cls.filter(
            user__email=user_email, date__startswith=month.date().isoformat()[:7]
        ).all()


class MembershipModel(Model):
    """Membership model. Contains information related to
    a user membership which includes type of membership
    and expiration date.
    
    The status field indicatest the membership status
        - ACTIVE: membership is active and can be cancelled
        - EXPIRED: membership is at past expiration date,
                membership could be renewed, which will change status
                back to ACTIVE.
        - CANCELLED: membership was cancelled. When membership is cancelled
                cancel_reason and cancel_suggestion might contain some data.
                Will only get to this status from ACTIVE.
    """

    id = IntField(pk=True)
    user = ForeignKeyField("models.UserModel")
    type = IntEnumField(MembershipType)
    start_time = DateField(default=datetime.today())
    end_time = DateField(default=datetime.today())
    status = CharEnumField(MembershipStatus, max_length=64)
    cancel_reason = CharField(max_length=160, default="")
    cancel_suggestion = CharField(max_length=160, default="")
