#!/bin/bash

# DOCKER ONLY

# assuming that the running db container is named db
# This healthcheck already exists in docker-compose.
# Leaving it also here in case more actions need to be implemented
until nc -z db 5432; do
    echo "$(date) - waiting database container to get up ..."
    sleep 1
done

./manage.py migrate --noinput --settings djboiler.main.settings.prod
/usr/local/bin/uwsgi --uid user --gid user --http :8000 \
                     --master --processes 2 --threads 2 \
                     --module djboiler.main.wsgi
