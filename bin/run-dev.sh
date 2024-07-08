#!/bin/bash

set -e

./manage.py migrate

# ReStart the development server every time it exits
while :; do
    ./manage.py runserver_plus 0.0.0.0:8000 \
                --settings djboiler.main.settings.dev
done