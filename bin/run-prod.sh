#!/bin/bash

# todo
# essentially runs docker, which uses docker/run.sh

CURRENT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR=$(dirname "$CURRENT_DIR")

cd "$ROOT_DIR" || exit 1

if [ ! -f  "./.env" ];  then
  cp .env.docker .env  || exit 1
fi

docker compose up -d
