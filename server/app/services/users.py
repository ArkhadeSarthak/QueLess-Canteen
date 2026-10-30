from sqlalchemy.orm import Session
from app.models.userModel import User
from fastapi import HTTPException, Depends, status
from app.schemas.users import UpdateUser


def get_all_users(db: Session):
    try:
        users = db.query(User).all()

        return users

    except HTTPException:
        raise

    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to fetch users: {str(e)}",
        )


def get_user_by_id(db: Session, user_id: str):
    try:
        user = db.query(User).filter(User.id == user_id).first()

        if not user:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND, detail="User not found"
            )

        return user

    except HTTPException:
        raise

    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to fetch user: {str(e)}",
        )


def update_user(db: Session, user: UpdateUser, id: str):
    try:
        existing_user = db.query(User).filter(User.id == id).first()
        if not existing_user:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="User not found",
            )

        existing_user.name = user.name
        existing_user.email = user.email
        existing_user.profile_image = user.profile_image

        db.commit()
        db.refresh(existing_user)

    except HTTPException:
        raise

    except Exception as e:
        db.rollback()
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to update user : {str(e)}",
        )
