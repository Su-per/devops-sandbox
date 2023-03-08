from fastapi import FastAPI
import random

r = random.randrange(1,100)
app = FastAPI()

@app.get("/")
def index():
    while True:
        pass
