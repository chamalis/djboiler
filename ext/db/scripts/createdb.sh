#!/bin/bash

# this script is included in case we want multiple dbs in the same container

set -e
set -u

function create_user_and_database() {
	local DB_NAME="$1"
	local USER_NAME="$2"

	# Create the user if it does not already exist
	if ! psql -lqt | cut -d \| -f 2 | grep -qw "$USER_NAME"; then
		echo "Creating user '$USER_NAME' ..."
		psql -v ON_ERROR_STOP=1 --username "$USER_NAME" <<-EOSQL
			CREATE USER "$USER_NAME";
		EOSQL
		echo "User: $USER_NAME created"
	fi

	# Create the database if it does not already exist
	if ! psql -lqt | cut -d \| -f 1 | grep -qw "$DB_NAME"; then
		echo "Creating database '$DB_NAME' ..."
		psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
			CREATE DATABASE "$DB_NAME";
			GRANT ALL PRIVILEGES ON DATABASE "$DB_NAME" TO "$USER_NAME";
		EOSQL
		echo "DB: $POSTGRES_DB created"
	fi
}

if [ -n "$DBs" ]; then
  for db in $(echo "$DBs" | tr ',' ' '); do
		create_user_and_database "$db" "$POSTGRES_USER"
	done
fi