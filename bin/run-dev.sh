#!/bin/bash

set -e

# generate and apply schema changes
./manage.py makemigrations --noinput --settings djboiler.main.settings.dev
./manage.py migrate --noinput --settings djboiler.main.settings.dev
# generate static files
./manage.py collectstatic --noinput -c --settings djboiler.main.settings.dev

# ReStart the development server every time it exits
while :; do
    ./manage.py runserver_plus 0.0.0.0:8000 --settings djboiler.main.settings.dev
done