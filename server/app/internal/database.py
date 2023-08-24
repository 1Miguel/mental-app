from enum import Enum
from passlib.hash import bcrypt
from typing_extensions import Self
from tortoise.fields import DatetimeField, IntEnumField, IntField, CharField
from tortoise.models import Model


class MoodId(Enum):
    AWFUL = 0
    BAD = 1
    UNSURE = 2
    GOOD = 3
    GREAT = 4


class UserModel(Model):
    id = IntField(pk=True)
    username = CharField(50, unique=True)
    password_hash = CharField(128)

    @classmethod
    async def get_user(cls, username: str) -> Self:
        return cls.get(username=username)

    def verify_password(self, password) -> bool:
        return bcrypt.verify(password, self.password_hash)


class Mood(Model):
    id = IntField(pk=True)


class MoodModel(Model):
    id = IntField(pk=True)
    user_id = IntField()
    mood_id = IntEnumField(MoodId)
    date = DatetimeField(auto_now=True)
