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


class TokenResponse(BaseModel):
    message: str
    access_token: str
    token_type: str = "bearer"
    id: str
    name: str
    roll_no: str
    email: str


class UpdateUser(BaseModel):
    name: str
    roll_no: str
    university: str
    course: str


class UpdateProfileImage(BaseModel):
    profile_image: str | None = None


class ChangePassword(BaseModel):
    old_password: str
    new_password: str
