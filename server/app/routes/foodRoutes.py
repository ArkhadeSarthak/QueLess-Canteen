from fastapi import APIRouter, status, Depends, HTTPException
from app.schemas.foods import NewFoodItem, FoodItemRespone
from app.core.database import get_db
from sqlalchemy.orm import Session
from app.services import foods as food_services
from app.core.security import get_current_user
from app.models.userModel import User

router = APIRouter(prefix="/food", tags=["Food Routes"])


@router.post(
    "/new-item", status_code=status.HTTP_201_CREATED, summary="Creates new food item"
)
def create_food_item(
    item: NewFoodItem,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    if current_user.role != "chief":
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="You can't add a food item",
        )

    try:
        return food_services.create_food_item(db, item)

    except HTTPException:
        raise

    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"An unexpected error occurred during creating an item : {str(e)}",
        )


@router.get("/", response_model=list[FoodItemRespone])
def get_all_food_items(db: Session = Depends(get_db)):
    try:
        return food_services.get_all_food_items(db)

    except HTTPException:
        raise

    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"An unexpected error occurred during featchin food items : {str(e)}",
        )
