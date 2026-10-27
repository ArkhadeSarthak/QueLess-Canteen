from fastapi import APIRouter, HTTPException, Depends, status
from app.schemas.users import UserResponse, TokenResponce
from app.schemas.auth import UserSignUp, UserLogin
from sqlalchemy.orm import Session
from app.core.database import get_db
from app.services import auth as auth_services
from app.models.userModel import User
from app.core.security import get_current_user

router = APIRouter(prefix="/auth", tags=["Auth Routes"])


@router.post(
    "/register",
    response_model=UserResponse,
    status_code=status.HTTP_201_CREATED,
    summary="User Register",
)
def signup_user(user: UserSignUp, db: Session = Depends(get_db)):
    try:
        return auth_services.signup_user(db, user)

    except HTTPException:
        raise

    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"An unexpected error occurred during signup: {str(e)}",
        )


@router.post("/login", response_model=TokenResponce, summary="User Login (return JWT)")
def login_user(user: UserLogin, db: Session = Depends(get_db)):
    try:
        return auth_services.login_user(db, user)

    except HTTPException:
        raise

    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"An unexpected error occurred during login: {str(e)}",
        )


@router.get(
    "/me", response_model=UserResponse, summary="Get current user profile (Proteted)"
)
def get_user_profile(current_user: User = Depends(get_current_user)):
    return current_user
