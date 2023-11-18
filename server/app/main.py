""" Main App.py

Contains app entry point and all setup routine and which include
setting up the fastapi server, database initialisation etc.

date: 02/11/2023
"""

# ---- standard imports
import sys
import logging
from typing import Dict

# ---- third-party imports
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from tortoise.contrib.fastapi import register_tortoise

# ---- internal modules
from internal.database import AppointmentServiceModelStats
from routers.account import AccountManager
from routers.appointment import Appointment
from routers.mood_logger import MoodLogger
from routers.thread_manager import ThreadManager
from routers.admin import AdminManager
from routers.notify import Notifier

# ------------------------------------------------------ #
# Debug
# ------------------------------------------------------ #
log = logging.getLogger(__name__)

# TODO: Add a flag if logging must be displayed in the terminal
#       flag can either be an env variable or from a file.
#       another option is for this to be in the unit test file.
log.setLevel(logging.DEBUG)
handler = logging.StreamHandler(sys.stdout)
handler.setLevel(logging.DEBUG)
handler.setFormatter(logging.Formatter("%(levelname)s: %(asctime)-15s : %(message)s"))
log.addHandler(handler)

# ------------------------------------------------------ #
# Main App Instance
# ------------------------------------------------------ #
app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ------------------------------------------------------ #
# Database
# ------------------------------------------------------ #
# connect to the database, create a database if does not exist
from pathlib import Path as _Path
db = _Path(__file__).parents[2].joinpath("db.sqlite3")
register_tortoise(
    app,
    db_url=f"sqlite://{db}",
    modules={"models": ["internal.database"]},
    generate_schemas=True,
)


# ------------------------------------------------------ #
# API Routers
# ------------------------------------------------------ #
account_manager = AccountManager(log=log)
appointment = Appointment(log=log)
mood_logger = MoodLogger(log=log)
thread_manager = ThreadManager(log=log)
admin_manager = AdminManager(log=log)
notifier = Notifier(log=log)

app.include_router(account_manager.router)
app.include_router(appointment.router)
app.include_router(mood_logger.router)
app.include_router(thread_manager.router)
app.include_router(admin_manager.router)


# ------------------------------------------------------ #
# Main Routes
# ------------------------------------------------------ #
@app.on_event("startup")
async def startup() -> None:
    """Routine at application startup."""
    log.info("App start up routine...")
    await admin_manager.setup_default_admin("admin0@mentalapp.com", "testadminpassword", False)
    await admin_manager.setup_default_admin("superadmin0@mentalapp.com", "testsuperadminpassword", True)
    await AppointmentServiceModelStats.init_defaults()


@app.on_event("shutdown")
async def shutdown() -> None:
    """Route at application shutdown"""
    log.info("App shutdown routine...")


@app.get("/")
def index() -> Dict[str, str]:
    """Index route.
    TODO: Implement the right routine"""
    return {"message": "Hello World"}


# ------------------------------------------------------ #
# Main entry point
# ------------------------------------------------------ #


def run() -> None:
    import uvicorn

    uvicorn.run(app, host="127.0.0.1", port=8080)


if __name__ == "__main__":
    run()
