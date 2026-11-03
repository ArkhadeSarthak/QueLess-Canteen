from sqlalchemy.orm import Session
from app.models.userModel import User
from fastapi import HTTPException, Depends, status
from app.schemas.users import UpdateUser, UpdateProfileImage, ChangePassword
from app.core.security import hash_password, verify_password, create_access_token


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
        existing_user.roll_no = user.roll_no
        existing_user.university = user.university
        existing_user.course = user.course

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


def update_profile_image(db: Session, image_url: UpdateProfileImage, id: str):
    try:
        existing_user = db.query(User).filter(User.id == id).first()
        if not existing_user:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="User not found",
            )

        existing_user.profile_image = image_url.profile_image

        db.commit()
        db.refresh(existing_user)

    except HTTPException:
        raise

    except Exception as e:
        db.rollback()
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to update image : {str(e)}",
        )


def change_user_password(db: Session, password: ChangePassword, id: str):
    try:
        existing_user = db.query(User).filter(User.id == id).first()
        if not existing_user:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="User not found",
            )

        is_valid = verify_password(password.old_password, existing_user.password)

        if not is_valid:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Password does not match",
            )

        hashed_password = hash_password(password.new_password)

        existing_user.password = hashed_password

        db.commit()
        db.refresh(existing_user)

    except HTTPException:
        raise

    except Exception as e:
        db.rollback()
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to change password : {str(e)}",
        )
