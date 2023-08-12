import os
import sys
import logging
from fastapi import FastAPI

log = logging.getLogger(__name__)
log.addHandler(logging.NullHandler())
# set the "True" to "False" at some point
# leave it as it is for now
if bool(os.environ.get("TEST_LOG_ENABLE", True)):
    handler = logging.StreamHandler(sys.stdout)
    handler.setLevel(logging.DEBUG)
    handler.setFormatter(
        logging.Formatter(
            fmt="%(asctime)-15s %(name)-8s %(threadName)s %(levelname)s: %(message)s"
        )
    )
    log.addHandler(handler)
    log.setLevel(logging.DEBUG)

log.debug("Starting")

app = FastAPI()


@app.get("/")
async def root():
    log.debug("Hello World!")
    return {"message": "Hello World"}
