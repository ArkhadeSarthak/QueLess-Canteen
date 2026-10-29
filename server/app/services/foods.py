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
            image_url=foodItem.image_url,
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


def delete_food_item(db: Session, id: int):
    try:
        existing_item = db.query(FoodItems).filter(FoodItems.id == id).first()

        if not existing_item:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Food item not available or already deleted",
            )

        db.delete(existing_item)
        db.commit()

        return {
            "message": "Food item deleted successfully",
        }

    except HTTPException:
        raise

    except Exception as e:
        db.rollback()
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to delete food item: {str(e)}",
        )


def update_food_item(db: Session, foodItem: NewFoodItem, id: int):
    try:
        existing_item = db.query(FoodItems).filter(FoodItems.id == id).first()
        if not existing_item:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Item not found",
            )

        existing_item.name = foodItem.name
        existing_item.description = foodItem.description
        existing_item.price = foodItem.price
        existing_item.category = foodItem.category
        existing_item.image_url = foodItem.image_url

        db.commit()
        db.refresh(existing_item)

        return existing_item

    except HTTPException:
        raise

    except Exception as e:
        db.rollback()
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to update food item: {str(e)}",
        )
