from pydantic import BaseModel


class UserResponse(BaseModel):
    id: str
    name: str
    roll_no: str
    role: str
    email: str
    profile_image: str | None = None
    university: str
    course: str


class TokenResponce(BaseModel):
    message: str
    access_token: str
    token_type: str = "bearer"
    id: str
    name: str
    roll_no: str
    email: str
    
    
class UpdateUser(BaseModel):
    name: str
    email: str
    profile_image: str | None = None