from pydantic import BaseModel


class MoodLog(BaseModel):
    """Daily mood API schema.
    Method: POST
    """
    mood: int

class UserApi(BaseModel):
    """API model of a users."""

    email: str
    password_hash: str
    firstname: str
    lastname: str
    address: str
    age: int
    occupation: str