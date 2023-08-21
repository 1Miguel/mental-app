from enum import Enum
from typing import List, Optional
from sqlalchemy import (
    create_engine,
    Integer,
    String,
    ForeignKey,
    select,
    DateTime,
    TIMESTAMP,
    Enum as SqlEnum,
)
from sqlalchemy.orm import (
    DeclarativeBase,
    Mapped,
    relationship,
    mapped_column,
    Session,
    sessionmaker,
)


class _Base(DeclarativeBase):
    """SQL Alchemy Declarative Base."""


class MoodId(Enum):
    AWFUL = 0
    BAD = 1
    UNSURE = 2
    GOOD = 3
    GREAT = 4


class UserAccount(_Base):
    __tablename__ = "user_account"
    id: Mapped[int] = mapped_column(primary_key=True)
    email: Mapped[str] = mapped_column(String())
    password: Mapped[str] = mapped_column(String())
    name: Mapped[str] = mapped_column(String())
    mood_list: Mapped[List["Mood"]] = relationship(
        back_populates="user", cascade="all, delete-orphan"
    )

    def __repr__(self) -> str:
        return f"<id={self.id}, name={self.name}>, moods={self.mood_list}"


class Mood(_Base):
    __tablename__ = "mood_enum"
    id: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    user_id: Mapped[int] = mapped_column(ForeignKey("user_account.id"))
    mood_id: Mapped[MoodId] = mapped_column(SqlEnum(MoodId))
    date: Mapped[TIMESTAMP] = mapped_column(TIMESTAMP(timezone=True))

    user: Mapped[UserAccount] = relationship(back_populates="mood_list")

    def __repr__(self) -> str:
        return f"<id={self.id}, user_id={self.user_id}, mood_id={self.mood_id}, date={self.date}>"


# SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)


class Database:
    def __init__(self, db: str, echo: bool = False) -> None:
        self._engine = create_engine(f"sqlite:///{db}", echo=echo)
        # create all database schemas
        _Base.metadata.create_all(self._engine)
        # open database session
        self._session = Session(self._engine)

    def create_account(self, email: str, name: str, password: str) -> None:
        """Create a new account in the database.

        Args:
            email (str): Email used by new account.
            name (str): Name of the user.
            password (str): Password used by this account.
        """
        # check if a user account is already using this email
        user_account = self.get_account(email)
        if user_account is None:
            # email is good, store to database
            new_user = UserAccount(
                email=email,
                password=password,
                name=name,
                mood_list=[],
            )
            self._session.add(new_user)
            self._session.commit()

    def get_account(self, email: str) -> Optional[UserAccount]:
        """Get the account by email.

        Args:
            email (str): Email to find.

        Returns:
            UserAccount: User Account email is binded to.
        """
        return self._session.scalar(
            select(UserAccount).where(UserAccount.email.is_(email))
        )
