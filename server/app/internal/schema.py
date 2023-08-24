from pydantic import BaseModel

class UserSchema(BaseModel):
    """ User authentication schema."""
    name: str
    email: str
    password: str
