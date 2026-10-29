from fastapi import FastAPI
from app.core.database import Base, engine
from fastapi.middleware.cors import CORSMiddleware
from app.routes import authRoutes, userRoutes, foodRoutes, imageRoutes

app = FastAPI(
    title="QueueLess Canteen Backend",
    description="It is a app created for make communication of database with frontend",
    version="1.0.0",
)


app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(authRoutes.router)
app.include_router(userRoutes.router)
app.include_router(foodRoutes.router)
app.include_router(imageRoutes.router)

try:
    Base.metadata.create_all(bind=engine)
    print("Tables Created Successfully")
except Exception as e:
    print(f"Error creating database tables on startup: {e}")


@app.get("/")
def home():
    return {"message": "Welcome to QueueLess Canteen software"}


@app.get("/health")
def health():
    return {"status": "Healthy", "running": "Okk"}
