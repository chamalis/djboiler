#!/bin/bash

ROOT_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/..")
ENV_DIR="${ROOT_DIR}/envs/dev"

cd "$ROOT_DIR" || exit 1

if [[ ! -f  "${ENV_DIR}/.env" ]];  then
  cp "${ENV_DIR}/.env.template" "${ENV_DIR}/.env"  || exit 1
  read -p "${ENV_DIR}/.env was just created automatically.
          Do you want to exit to adjust the configuration? (Y/n)" option
  [[ $option != [nN] ]] && exit 0
fi

ln -sf "${ENV_DIR}/.env" .env

docker compose --profile dev build


