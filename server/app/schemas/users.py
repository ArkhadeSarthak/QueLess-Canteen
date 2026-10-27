from pydantic import BaseModel


class UserResponse(BaseModel):
    id: str
    name: str
    roll_no: str
    email: str
    profile_image: str


class TokenResponce(BaseModel):
    message: str
    access_token: str
    token_type: str = "bearer"
    id: str
    name: str
    roll_no: str
    email: str
