# todo
from decouple import AutoConfig

ENVIRONMENT = "DEV"

from .base import *

DEBUG = config('DEBUG', cast=bool, default=True)

