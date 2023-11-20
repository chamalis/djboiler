#!/bin/bash

# DOCKER ONLY

# assuming that the running database container is named db
until nc -z db 5432; do
    echo "$(date) - waiting postgres container to get up ..."
    sleep 1
done

./manage.py migrate --noinput
/usr/local/bin/uwsgi --uid user --gid user --http :8000 \
                     --master --processes 2 --threads 2 --module djboiler.main.wsgi
