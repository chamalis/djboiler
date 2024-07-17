#!/bin/bash

set -e

# This healthcheck already exists in docker-compose.
# Leaving it also here in case more actions need to be implemented
until nc -z db 5432; do
    echo "$(date) - waiting database container to get up ..."
    sleep 1
done

# generate and apply schema changes
./manage.py makemigrations --noinput --settings djboiler.main.settings.dev
./manage.py migrate --noinput --settings djboiler.main.settings.dev
# generate static files
./manage.py collectstatic --noinput -c --settings djboiler.main.settings.dev

# ReStart the development server every time it exits
while :; do
    ./manage.py runserver_plus 0.0.0.0:8000 --settings djboiler.main.settings.dev
done