"""Database.py
This module contains all database schema models.

date: 10/07/2023
"""
from enum import IntEnum, Enum, auto
from datetime import datetime
from typing import Any, List, Optional
from typing_extensions import Self
from passlib.hash import bcrypt
from tortoise.expressions import Q
from tortoise.models import Model
from tortoise.fields import (
    DateField,
    DatetimeField,
    IntEnumField,
    IntField,
    CharField,
    ForeignKeyField,
    CharEnumField,
    ReverseRelation,
    BooleanField,
)


def _iso_datetime_month(d: datetime) -> str:
    # the month is in datetime isoformat YYYY-MM-DD to get only the
    # year and month, we need to cut the string
    return d.date().isoformat()[:7]


def is_iso_month(month: str) -> bool:
    try:
        datetime.fromisoformat(f"{month}-01")
    except:
        return False
    return True


class MoodId(IntEnum):
    """Mood Score Ids."""

    UNDEFINED = 0
    HAPPY = auto()
    SAD = auto()
    CONFUSED = auto()
    SCARED = auto()
    ANGRY = auto()
    NUM_MOODS = auto()


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
    LIFE = auto()
    STUDENT = auto()


class JwtBlacklist(Model):
    id = IntField(pk=True)
    token = CharField(1024)


class UserPasswordHistoryModel(Model):
    id = IntField(pk=True)
    user = ForeignKeyField("models.UserModel")
    password_hash = CharField(128, default="")


class UserModel(Model):
    """DataBase model of a users."""

    id = IntField(pk=True)
    email = CharField(128, unique=True)
    password_hash = CharField(128, default="")
    firstname = CharField(128, default="")
    lastname = CharField(128, default="")
    username = CharField(128, default="")
    address = CharField(256, default="")
    age = IntField(default=0)
    occupation = CharField(128, default="")
    birthday = CharField(128, default="")
    mobile_number = CharField(max_length=13, default="")

    @classmethod
    async def get_user(cls, email: str) -> Self:
        return cls.get(email=email)

    def verify_password(self, password) -> bool:
        return bcrypt.verify(password, self.password_hash)

    @property
    def fullname(self) -> str:
        return f"{self.firstname} {self.lastname}"


class UserSettingModel(Model):
    id = IntField(pk=True)
    user = ForeignKeyField("models.UserModel")
    local_notif = BooleanField(default=False)


class AdminModel(Model):
    id = IntField(pk=True)
    admin_user = ForeignKeyField("models.UserModel")


class AppointmentStatus(str, Enum):
    """Appointment Status."""

    PENDING = "PENDING"
    RESERVED = "RESERVED"
    CANCELLED = "CANCELLED"
    RESCHEDULE = "RESCHEDULE"


class AppointmentServices(str, Enum):
    OCCUPATIONAL_THERAPY = "OCCUPATIONAL_THERAPY"
    PSYCHIATRIC_CONSULTATION = "PSYCHIATRIC_CONSULTATION"
    COUNSELING = "COUNSELING"
    PSYCHOLOGICAL_ASSESMENT = "PSYCHOLOGICAL_ASSESMENT"


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
        return await cls.filter(user__email=user_email, date__startswith=month.date().isoformat()[:7]).all()

    @classmethod
    async def get_today(cls, user_email: str) -> Optional[Self]:
        """Get all mood data filtered by month.

        Args:
            month (datetime): Month datetime filter.

        Returns:
            List[Self]: List of data filtered by month
        """
        # the month is in datetime isoformat YYYY-MM-DD to get only the
        # year and month, we need to cut the string
        q = await cls.filter(user__email=user_email, date__startswith=datetime.today().date().isoformat()).all()
        return q[0] if q else None


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


class ThreadModel(Model):
    id = IntField(pk=True)
    user = ForeignKeyField("models.UserModel")
    creator = CharField(max_length=64)
    created = DatetimeField(auto_now=True)
    topic = CharField(max_length=160)
    content = CharField(max_length=256)
    comments = ReverseRelation["ThreadCommentModel"]
    num_likes = IntField(default=0)
    num_comments = IntField(default=0)


class ThreadCommentModel(Model):
    id = IntField(pk=True)
    user = ForeignKeyField("models.UserModel")
    thread = ForeignKeyField("models.ThreadModel")
    created = DatetimeField(auto_now=True)
    content = CharField(max_length=256)

    @classmethod
    async def get_thread_comments(cls, thread_id: int) -> List["ThreadCommentModel"]:
        return await cls.filter(thread__id=thread_id).order_by("-created")


class ThreadUserLikeModel(Model):
    id = IntField(pk=True)
    thread = ForeignKeyField("models.ThreadModel")
    user = ForeignKeyField("models.UserModel")
    liked_at = DatetimeField(auto_now=True)

    @classmethod
    async def get_all_thread_like_by_user(cls, user_id: int) -> List["ThreadUserLikeModel"]:
        return await cls.filter(user__id=user_id)

    @classmethod
    async def get_thread_like_by_user(cls, user_id: int, thread_id: int) -> "ThreadUserLikeModel":
        return await cls.first(user__id=user_id, thread__id=thread_id)


class Doctor(Model):
    """Model that links user account(doctor) and health center."""

    id = IntField(pk=True)
    user_id = ForeignKeyField("models.UserModel")
    # center = ForeignKeyField("models.HealthCenter")


class AppointmentServiceModelStats(Model):
    id = IntField(pk=True)
    service = CharEnumField(AppointmentServices, max_length=64, unique=True)
    count = IntField(default=0)

    @classmethod
    async def init_defaults(self) -> None:
        [
            await AppointmentServiceModelStats(service=service).save()
            for service in AppointmentServices
            if not await AppointmentServiceModelStats.exists(service=service)
        ]


class AppointmentModel(Model):
    """Model the describe an appointment.

    An appointment basically consists of a patient(user), doctor(user) and the
    scheduled duration of an appointment."""

    id = IntField(pk=True)
    patient = ForeignKeyField("models.UserModel")
    service = CharEnumField(AppointmentServices, max_length=64)
    # doctor = ForeignKeyField("models.Doctor")
    # center = ForeignKeyField("models.HealthCenter")
    start_time = DatetimeField()
    end_time = DatetimeField()
    status = CharEnumField(AppointmentStatus, max_length=64)
    created = DatetimeField(auto_now=True)
    concerns = CharField(max_length=160)

    @classmethod
    async def get_by_month(cls, date: datetime) -> List[Self]:
        """Get appointment by day."""
        return await cls.filter(start_time__startswith=_iso_datetime_month(date)).all()

    @classmethod
    async def get_by_datetime(cls, start_time: datetime, end_time: datetime) -> List[Self]:
        """Get appointment by datetime."""
        return await cls.filter(
            Q(start_time__startswith=start_time.isoformat()) | Q(end_time__startswith=end_time.isoformat())
        ).all()

    @classmethod
    async def get_upcoming(cls) -> List[Self]:
        date = datetime.now()
        return await cls.filter(Q(start_time__gt=date)).all()
