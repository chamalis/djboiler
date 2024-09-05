#!/bin/bash

# essentially runs docker, which uses ${ENV_DIR}/run.sh

# if also need to build e.g altered dockerfile, pass --build
if [ "$1" == "--build" ]; then
    docker compose --profile dev build app-dev
fi

docker compose --profile dev up -d

# Ensure that the script returns zero for the CI
exit 0
