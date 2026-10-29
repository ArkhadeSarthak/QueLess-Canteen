from pydantic import BaseModel
from decimal import Decimal


class NewFoodItem(BaseModel):
    name: str
    description: str
    price: Decimal
    category: str
    image_url: str


class FoodItemRespone(BaseModel):
    id: int
    name: str
    description: str
    price: Decimal
    category: str
    image_url: str | None = None
    is_available: bool
