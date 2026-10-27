from fastapi import status, HTTPException
from sqlalchemy.orm import Session
from app.core.security import hash_password, verify_password, create_access_token
from app.models.userModel import User
from app.schemas.auth import UserSignUp, UserLogin
import uuid


def register_user(db: Session, user: UserSignUp):
    try:
        existing_user = db.query(User).filter(User.email == user.email).first()
        if existing_user:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Email already registered",
            )

        existing_roll = db.query(User).filter(User.roll_no == user.roll_no).first()
        if existing_roll:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Roll number already registered",
            )

        hashed_password = hash_password(user.password)

        new_user = User(
            name=user.name,
            email=user.email,
            roll_no=user.roll_no,
            password=hashed_password,
        )

        db.add(new_user)
        db.commit()
        db.refresh(new_user)

        return new_user

    except HTTPException:
        raise

    except Exception as e:
        db.rollback()
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to register user: {str(e)}",
        )


signup_user = register_user


def login_user(db: Session, user: UserLogin):
    try:
        existing_user = db.query(User).filter(User.email == user.email).first()

        if not existing_user:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Invalid email or password",
            )

        is_valid = verify_password(user.password, existing_user.password)

        if not is_valid:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Invalid email or password",
            )

        access_token = create_access_token(
            data={"sub": str(existing_user.id), "email": existing_user.email}
        )

        return {
            "message": "Login Successful",
            "access_token": access_token,
            "token_type": "bearer",
            "id": existing_user.id,
            "name": existing_user.name,
            "roll_no": existing_user.roll_no,
            "email": existing_user.email,
        }

    except HTTPException:
        raise

    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to process login: {str(e)}",
        )
