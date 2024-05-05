from .base import *

# todo

ENVIRONMENT = config("ENV", default="dev")

DEBUG = config('DEBUG', cast=bool, default=True)
