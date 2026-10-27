from fastapi import APIRouter, HTTPException, Depends, status
from sqlalchemy.orm import Session
from app.models.userModel import User
from app.core.database import get_db
from app.schemas.users import UserResponse
from app.services import users as user_serives
from app.core.security import get_current_user

router = APIRouter(prefix="/users", tags=["User Routes"])


@router.get("/", response_model=list[UserResponse])
def get_all_users(
    db: Session = Depends(get_db), current_user: User = Depends(get_current_user)
):
    if current_user.role != "administrator":
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="You are not able to see other users",
        )

    try:
        return user_serives.get_all_users(db)

    except HTTPException:
        raise

    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"An unexpected error occurred while fetching users: {str(e)}",
        )


@router.get("/{id}", response_model=UserResponse)
def get_user_by_id(
    id: str,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    if current_user.role != "administrator":
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="You are not able to see other user",
        )

    try:
        return user_serives.get_user_by_id(db, id)

    except HTTPException:
        raise

    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"An unexpected error occurred while fetching user: {str(e)}",
        )
