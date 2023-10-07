from enum import IntEnum, auto
from passlib.hash import bcrypt
from typing_extensions import Self
from tortoise.fields import (
    DateField,
    IntEnumField,
    IntField,
    CharField,
    BooleanField,
    ForeignKeyField,
    DecimalField,
)
from tortoise.models import Model
from datetime import datetime

DATETIME_FOREVER = datetime(9999, 12, 1)

class MoodId(IntEnum):
    """Mood Score Ids."""

    AWFUL = 0
    BAD = auto()
    UNSURE = auto()
    GOOD = auto()
    GREAT = auto()


class MembershipType(IntEnum):
    """Member Subscription Type Ids."""

    LIFE = 0
    CONTRIBUTING = auto()
    SUSTAINING = auto()
    CORPORATE = auto()
    COLLEGE = auto()
    SENIOR_HS = auto()
    JUNIOR_HS = auto()


class AppointmentType(IntEnum):
    """Appointment Service Type Ids."""

    COUNSELING = 0
    CONSULTATION = 1
    THERAPY = 2
    ASSESSMENT = 3


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

    @classmethod
    async def get_user(cls, email: str) -> Self:
        return cls.get(email=email)

    def verify_password(self, password) -> bool:
        return bcrypt.verify(password, self.password_hash)


class MembershipService(Model):
    """A lookup model of all membership services.
    Basically, a membership consist of:
        1. Priviledge type
        2. Duration, could be a lifetime
        3. Price amount to avail the membership"""
    id = IntField(pk=True)
    membership_type = IntEnumField(MembershipType)
    year_duration = IntField()
    price = DecimalField(max_digits=5, decimal_places=5)

    @classmethod
    async def init(cls) -> None:
        """Initializes the database model."""
        memberships = [
            cls(membership_type=MembershipType.LIFE, year_duration=9999, price=3000),
            cls(membership_type=MembershipType.CONTRIBUTING, year_duration=1, price=300),
            cls(membership_type=MembershipType.CORPORATE, year_duration=1, price=10000),
            cls(membership_type=MembershipType.SUSTAINING, year_duration=1, price=3000),
            cls(membership_type=MembershipType.COLLEGE, year_duration=1, price=100),
            cls(membership_type=MembershipType.SENIOR_HS, year_duration=1, price=50),
            cls(membership_type=MembershipType.JUNIOR_HS, year_duration=1, price=20),
        ]
        for data in memberships:
            await data.save()


class Membership(Model):
    id = IntField(pk=True)
    user = ForeignKeyField("models.UserModel")
    type = IntEnumField(MembershipType)
    start_time = DateField()
    end_time = DateField()


class MoodModel(Model):
    id = IntField(pk=True)
    user = ForeignKeyField("models.UserModel")
    mood = IntEnumField(MoodId)
    date = DateField()


class HealthCenter(Model):
    id = IntField(pk=True)
    name = CharField(max_length=128)

    @classmethod
    async def init(cls) -> None:
        cls(name="Philippine Mental Health Association-Palawan Chapter")


class Doctor(Model):
    """Model that links user account(doctor) and health center."""
    id = IntField(pk=True)
    user = ForeignKeyField("models.UserModel")
    center = ForeignKeyField("models.HealthCenter")


class Appointment(Model):
    """Model the describe an appointment.

    An appointment basically consists of a patient(user), doctor(user) and the
    scheduled duration of an appointment."""
    id = IntField(pk=True)
    time_created = DateField()
    patient = ForeignKeyField("models.UserModel")
    center = ForeignKeyField("models.HealthCenter")
    start_time = DateField()
    end_time = DateField()
    cancelled = BooleanField()
