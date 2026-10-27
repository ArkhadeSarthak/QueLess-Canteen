from sqlalchemy import Column, String, Enum, DateTime
from app.core.database import Base
from datetime import datetime
import uuid


class User(Base):
    __tablename__ = "users"

    id = Column(
        String, primary_key=True, nullable=False, default=lambda: str(uuid.uuid4())
    )
    name = Column(String, nullable=False)
    email = Column(String, unique=True, nullable=False)
    roll_no = Column(String, unique=True, nullable=False)
    password = Column(String, nullable=False)
    profile_image = Column(String)
    role = Column(
        Enum("student", "chief", "administrator", name="user_role"),
        nullable=False,
        default="student",
    )
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)
    updated_at = Column(
        DateTime, default=datetime.utcnow, onupdate=datetime.utcnow, nullable=False
    )
