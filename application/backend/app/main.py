from fastapi import FastAPI

from .database import Base, engine
from .routes.health import router as health_router
from .routes.items import router as items_router

Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="AWS Cloud DevOps API",
    description="Production-style FastAPI backend for AWS Cloud DevOps Project",
    version="1.0.0",
)

app.include_router(health_router)
app.include_router(items_router)