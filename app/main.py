from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()


class Message(BaseModel):
    message: str
    sender: str

@app.get("/health")
def health():
    return {"status": "ok"}


@app.get("/info")
def info():
    return {"name": "secure-azure-platform", "version": "0.1"}


@app.post("/messages")
def create_message(data: Message):
    return {"received": data.message, "from": data.sender}
