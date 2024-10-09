#!/usr/bin/env python3
from fastapi import FastAPI, Response, Request, Header
from pydantic import BaseModel

app = FastAPI()
TOKEN = "secret"

# ---------------------------------------------------------------------------
# - Token auth method -
# ---------------------------------------------------------------------------
def check_auth(authorization_header): 
    if authorization_header == TOKEN : 
        return True
    else: 
        return False

# ---------------------------------------------------------------------------
# - Handle a GET request -
# ---------------------------------------------------------------------------
@app.get("/get")
def get_handler(request : Request, response : Response, arg = None ): 
    authorization_token = request.headers.get("Authorization", None)
    check_token = check_auth(authorization_token) 
    if check_token : 
        '''
        Work with query string
        '''
        print("input arg = {}".format(arg))

        '''
        Build response
        '''
        response_payload = {"status" : "done"}
        response.status_code = 200 
        response.headers["Content-Type"] = "application/json"
        return response_payload
    else : 
        response.status_code = 401
        return response


# ---------------------------------------------------------------------------
# - Handle a POST request -
# ---------------------------------------------------------------------------
class PredictPayload(BaseModel): 
    key : str
    value : int

@app.post("/post")
def post_handler(request : Request, response : Response, payload : PredictPayload): 
    authorization_token = request.headers.get("Authorization", None)
    check_token = check_auth(authorization_token) 
    if check_token : 
        '''
        Work with payload ... 
        '''
        payload_data = payload.dict()

        '''
        Build response
        '''
        response_payload = {"status" : "done"}
        response.status_code = 200 
        response.headers["Content-Type"] = "application/json"
        return response_payload
    else : 
        response.status_code = 401
        return response
