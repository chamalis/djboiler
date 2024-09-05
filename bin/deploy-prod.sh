#!/bin/bash

# essentially runs docker, which uses ${ENV_DIR}/run.sh

# if also need to build e.g altered dockerfile, pass --build
if [ "$1" == "--build" ]; then
    docker compose --profile prod build app-prod
fi

docker compose --profile prod up -d
