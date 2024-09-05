#!/bin/bash

### Do not manually run this file. It is supposed to be the  ###
### executable to launch the app inside the container        ###

SETTINGS_MODULE="djboiler.main.settings.dev"
WSGI_MODULE="djboiler.main.wsgi"

# assuming that the running db container is named db
# This healthcheck already overlaps in docker-compose.
# Leaving it also here in case more actions need to be implemented
until nc -z djdb 5432; do
    echo "$(date) - waiting database container to get up ..."
    sleep 1
done

# Apply database migrations
./manage.py makemigrations --settings "$SETTINGS_MODULE"  # Allow input for interactive use in dev
./manage.py migrate --settings "$SETTINGS_MODULE"

# Collect static files
# ./manage.py collectstatic --noinput --settings "$SETTINGS_MODULE" -c

# run uwsgi with development options like autoreload in case of code change
/usr/local/bin/uwsgi --uid user --gid user --http :8800 \
                     --py-call-uwsgi-fork-hooks --py-autoreload 1 \
                     --master --processes 1 --threads 1 \
                     --module "$WSGI_MODULE"
