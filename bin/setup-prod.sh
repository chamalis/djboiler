#!/bin/bash

# essentially runs docker, which uses ${ENV_DIR}/run.sh

# todo remote

ROOT_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/..")
ENV_DIR="${ROOT_DIR}/envs/prod"

cd "$ROOT_DIR" || exit 1

if [[ ! -f  "${ENV_DIR}/.env" ]];  then
  cp "${ENV_DIR}/.env.template" "${ENV_DIR}/.env"  || exit 1
  echo "
    ${ENV_DIR}/.env was just created automatically.
    Adjust your configuration and re-run the script"

  exit 0
fi

ln -sf "${ENV_DIR}/.env" .env

docker compose --profile prod build
