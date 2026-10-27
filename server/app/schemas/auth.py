from pydantic import BaseModel


class UserSignUp(BaseModel):
    name: str
    email: str
    roll_no: str
    password: str


UserRegister = UserSignUp


class UserLogin(BaseModel):
    email: str
    password: str
