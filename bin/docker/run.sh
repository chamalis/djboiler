#!/bin/bash

### Do not manually run this file. It is supposed to be the  ###
### executable to launch the app inside the container        ###

# assuming that the running db container is named db
# This healthcheck already overlaps in docker-compose.
# Leaving it also here in case more actions need to be implemented
until nc -z db 5432; do
    echo "$(date) - waiting database container to get up ..."
    sleep 1
done

 ./manage.py makemigrations --noinput --settings djboiler.main.settings.prod
 ./manage.py migrate --noinput --settings djboiler.main.settings.prod
 ./manage.py collectstatic --noinput -c
/usr/local/bin/uwsgi --uid user --gid user --http :8000 \
                     --py-call-uwsgi-fork-hooks --enable-threads \
                     --master --processes 2 --threads 2 \
                     --module djboiler.main.wsgi
