from pydantic import BaseModel

class User(BaseModel):
    """ User authentication schema."""
    name: str
    email: str
    password: str
