from enum import IntEnum
from passlib.hash import bcrypt
from typing_extensions import Self
from tortoise.fields import (
    DateField,
    IntEnumField,
    IntField,
    CharField,
    ForeignKeyField,
)
from tortoise.models import Model


class MoodId(IntEnum):
    AWFUL = 0
    BAD = 1
    UNSURE = 2
    GOOD = 3
    GREAT = 4


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


class MoodModel(Model):
    id = IntField(pk=True)
    user = ForeignKeyField("models.UserModel")
    mood = IntEnumField(MoodId)
    date = DateField()
