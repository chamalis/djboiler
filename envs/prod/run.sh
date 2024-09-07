#!/bin/bash

### Do not manually run this file. It is supposed to be the  ###
### executable to launch the app inside the container        ###

SETTINGS_MODULE="djboiler.main.settings.prod"
WSGI_MODULE="djboiler.main.wsgi"

# assuming that the running db container is named db
# This healthcheck already overlaps in docker-compose.
# Leaving it also here in case more actions need to be implemented
until nc -z djdb 5432; do
    echo "$(date) - waiting database container to get up ..."
    sleep 1
done

# Apply database migrations non-interactively
./manage.py makemigrations --noinput --settings "$SETTINGS_MODULE"
./manage.py migrate --noinput --settings "$SETTINGS_MODULE"

# Collect static files non-interactively
# ./manage.py collectstatic --noinput -settings "$SETTINGS_MODULE" -c

# Start uWSGI server in production mode
# shellcheck disable=SC2093
exec /usr/local/bin/uwsgi --uid user --gid user --socket :8000 \
                          --chmod-socket=664 -b 32768 \
                          --master --processes 4 --threads 2 \
                          --module "$WSGI_MODULE"
