#!/bin/bash

set -e

SETTINGS_MODULE="djboiler.main.settings.local"

# generate and apply schema changes
./manage.py makemigrations --noinput --settings "$SETTINGS_MODULE"
./manage.py migrate --noinput --settings "$SETTINGS_MODULE"
# generate static files
./manage.py collectstatic --noinput -c --settings "$SETTINGS_MODULE"

# ReStart the development server every time it exits
while :; do
    python -m pydevd_pycharm manage.py runserver_plus 0.0.0.0:8000 --settings "$SETTINGS_MODULE"
done