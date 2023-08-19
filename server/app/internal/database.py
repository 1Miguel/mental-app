from enum import Enum
from typing import List, Optional
from sqlalchemy import (
    create_engine,
    Column,
    Integer,
    String,
    ForeignKey,
    select,
    DateTime,
    TIMESTAMP,
    Enum as SqlEnum
)
from sqlalchemy.orm import DeclarativeBase, Mapped, relationship, mapped_column, Session

_db_engine = create_engine("sqlite://", echo=False)


class _Base(DeclarativeBase):
    """SQL Alchemy Declarative Base."""

class MoodId(Enum):
    AWFUL = 0
    BAD = 1
    UNSURE = 2
    GOOD = 3
    GREAT = 4

class User(_Base):
    __tablename__ = "user_account"
    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String())
    mood_list: Mapped[List["Mood"]] = relationship(back_populates="user", cascade="all, delete-orphan")

    def __repr__(self) -> str:
        return f"<id={self.id}, name={self.name}>, moods={self.mood_list}"

class Mood(_Base):
    __tablename__ = "mood_enum"
    id: Mapped[int] = mapped_column(primary_key=True)
    user_id: Mapped[int] = mapped_column(ForeignKey("user_account.id"))
    mood_id: Mapped[MoodId] = mapped_column(SqlEnum(MoodId))
    date: Mapped[TIMESTAMP] = mapped_column(TIMESTAMP(timezone=True))

    user: Mapped[User] = relationship(back_populates="mood_list")

    def __repr__(self) -> str:
        return f"<id={self.id}, user_id={self.user_id}, mood_id={self.mood_id}, date={self.date}>"

# create all database schemas
_Base.metadata.create_all(_db_engine)

if __name__ == "__main__":
    import datetime

    with Session(_db_engine) as session:
        # add a new mood in the mood list
        new_mood = Mood(
            id = 0,
            user_id = 123,
            mood_id = MoodId.GOOD,
            date = datetime.datetime.now()
        )
        # create a new user from model
        new_user = User(id=123, name="New User", mood_list=[new_mood,])
        # add a new user
        session.add(new_user)
        # commit from session
        session.commit()
        # get the current user
        user = session.scalar(select(User).where(User.name.is_("New User")))


        session.delete(new_user)

        mood = session.scalar(select(Mood).where(Mood.user_id.is_(user.id)))
        print(mood)

        