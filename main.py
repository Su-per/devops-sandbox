from fastapi import FastAPI
import random

def fib(n):
    _curr, _next = 0, 1
    for _ in range(n):
        _curr, _next = _next, _curr + _next
    return _curr

r = random.randrange(1,100)
app = FastAPI()

@app.get("/")
def index():
    a = fib(5000)
    return {"Hello": "World!", "ServerID": r, "fib_5000": a}
