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
)
from tortoise.models import Model


class MoodId(IntEnum):
    AWFUL = 0
    BAD = auto()
    UNSURE = auto()
    GOOD = auto()
    GREAT = auto()


class SubscriptionType(IntEnum):
    LIFE = 0
    CONTRIBUTING = auto()
    SUSTAINING = auto()
    CORPORATE = auto()


class ServiceType(IntEnum):
    pass


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


class Subscription(Model):
    id = IntField(pk=True)
    user = ForeignKeyField("models.UserModel")
    start_time = DateField()
    end_time = DateField()


class MoodModel(Model):
    id = IntField(pk=True)
    user = ForeignKeyField("models.UserModel")
    mood = IntEnumField(MoodId)
    date = DateField()


class ScheduleModel(Model):
    id = IntField(pk=True)
    user = ForeignKeyField("models.UserModel")
    type = IntEnumField(SubscriptionType)
    date_from = DateField()
    date_to = DateField()


class Appointment(Model):
    id = IntField(pk=True)
    time_created = DateField()
    patient = ForeignKeyField("models.UserModel")
    start_time = DateField()
    end_time = DateField()
    cancelled = BooleanField()
