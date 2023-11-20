from http.client import HTTPException

from main.strings import error_messages


class MyBaseError(HTTPException):
    status = 500
    message = error_messages.get(status, '')

    def __init__(self, **kwargs):
        super().__init__()
        self.message = kwargs.get('msg') or kwargs.get('message') or self.message
        self.status = kwargs.get('status') or kwargs.get('status_code') or self.status

    def __str__(self):
        return str(self.message)


class BadRequest(MyBaseError):
    status = 400
    msg = error_messages.get(status)


class AuthenticationError(BadRequest):
    status = 401
    msg = error_messages.get(status)


class PermissionException(MyBaseError):
    status = 403
    msg = error_messages.get(status)
