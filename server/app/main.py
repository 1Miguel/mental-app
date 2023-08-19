import os
import sys
import logging
from typing import List

import databases
import sqlalchemy
from fastapi import FastAPI
from pydantic import BaseModel

log = logging.getLogger(__name__)

@app.get("/")
async def root():
    log.debug("Hello World!")
    return {"message": "Hello World"}
