from .base import *

# todo

ENVIRONMENT = config("ENV", default="prod")

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = config('DEBUG', cast=bool, default=False)
