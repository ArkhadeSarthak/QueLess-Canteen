from sqlalchemy.orm import Session
from app.schemas.foods import NewFoodItem
from app.models.foodModel import FoodItems
from fastapi import HTTPException, status


def create_food_item(db: Session, foodItem: NewFoodItem):
    try:
        existing_item = (
            db.query(FoodItems).filter(FoodItems.name == foodItem.name).first()
        )
        if existing_item:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Food item already added",
            )

        new_food_item = FoodItems(
            name=foodItem.name,
            description=foodItem.description,
            price=foodItem.price,
            category=foodItem.category,
        )

        db.add(new_food_item)
        db.commit()
        db.refresh(new_food_item)

        return new_food_item

    except HTTPException:
        raise

    except Exception as e:
        db.rollback()
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to add food item: {str(e)}",
        )


def get_all_food_items(db: Session):
    try:
        food_items = db.query(FoodItems).all()
        return food_items

    except HTTPException:
        raise

    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to fetch food items : {str(e)}",
        )
