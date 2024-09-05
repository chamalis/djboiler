# todo

ENVIRONMENT = "PROD"

from .base import *

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = config('DEBUG', cast=bool, default=False)
ALLOWED_HOSTS.append("app-prod")
print(ALLOWED_HOSTS)
