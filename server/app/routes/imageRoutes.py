from fastapi import APIRouter, File, HTTPException, UploadFile
from fastapi.concurrency import run_in_threadpool
import cloudinary.uploader

router = APIRouter(prefix="/images", tags=["Images"])


MAX_FILE_SIZE = 5 * 1024 * 1024
ALLOWED_TYPES = {"image/jpeg", "image/png", "image/webp", "image/jpg"}


@router.post("/upload")
async def upload_image(file: UploadFile = File(...)):
    # if file.content_type not in ALLOWED_TYPES:
    #     raise HTTPException(
    #         status_code=400,
    #         detail="Only JPG, PNG, JPEG, and WEBP images are allowed",
    #     )

    try:
        contents = await file.read()

        if not contents:
            raise HTTPException(
                status_code=400,
                detail="The uploaded file is empty",
            )

        if len(contents) > MAX_FILE_SIZE:
            raise HTTPException(
                status_code=413,
                detail="Image size must be 5 MB or less",
            )

        result = await run_in_threadpool(
            cloudinary.uploader.upload,
            contents,
            folder="queueless_canteen",
            resource_type="image",
        )

        return {
            "message": "Image uploaded successfully",
            "image_url": result["secure_url"],
            "public_id": result["public_id"],
        }

    except HTTPException:
        raise

    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail="Image upload failed",
        ) from e

    finally:
        await file.close()
