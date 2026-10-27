from sqlalchemy import (
    Column,
    String,
    Integer,
    ForeignKey,
    Boolean,
    Numeric,
    CheckConstraint,
)
from app.core.database import Base
from datetime import datetime


class FoodItems(Base):
    __tablename__ = "food-items"

    id = Column(Integer, primary_key=True, nullable=False, autoincrement=True)
    name = Column(String, nullable=False)
    description = Column(String, nullable=False)
    price = Column(
        Numeric(10, 2),
        nullable=False,
    )
    category = Column(String, nullable=False)
    image_url = Column(String, nullable=True)
    is_available = Column(Boolean, nullable=False, default=True)

    __table_args__ = (
        CheckConstraint("price >= 0", name="check_food_price_non_negative"),
    )
