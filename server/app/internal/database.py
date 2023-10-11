"""Database.py
This module contains all database schema models.

date: 10/07/2023
"""
from enum import IntEnum, auto
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
)


class MoodId(IntEnum):
    """Mood Score Ids."""

    HAPPY = 0
    SAD = auto()
    CONFUSED = auto()
    SCARED = auto()
    ANGRY = auto()


class MembershipType(IntEnum):
    """Member Subscription Type Ids."""

    NONE = 0
    LIFE = auto()
    CONTRIBUTING = auto()
    SUSTAINING = auto()
    CORPORATE = auto()
    COLLEGE = auto()
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


if __name__ == "__main__":
    from tortoise import Tortoise, run_async

    async def main():
        await Tortoise.init(db_url="sqlite://db.sqlite3", modules={"models": ["__main__"]})
        await Tortoise.generate_schemas()

        user = await UserModel.get(email="johndoe@gmail.com")
        for day in range(1, 15, 1):
            today = datetime(year=2023, month=10, day=day)
            await MoodModel(user=user, mood=MoodId.GOOD, date=today, note="I feel good!").save()

        for d in await MoodModel.get_all_by_month(user.email, datetime.now()):
            print(d)

    run_async(main())
