#!/bin/bash

set -e
set -u

function create_database() {
	local database=$1
	echo "  Creating database '$database'"
	mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $database;"
}

function create_grand() {
	echo "  Creating grant rights"
	mysql -u root -p$MYSQL_ROOT_PASSWORD -e 'GRANT ALL PRIVILEGES ON *.* TO `root`@`%`;'
}

function show_created_databases() {
	echo "  Show databases"
	mysql -u root -p$MYSQL_ROOT_PASSWORD -e 'show databases;'
}

if [ -n "$MYSQL_MULTIPLE_DATABASES" ]; then
	echo "Multiple database creation requested: $MYSQL_MULTIPLE_DATABASES"
	for db in $(echo $MYSQL_MULTIPLE_DATABASES | tr ',' ' '); do
		create_database $db
	done
	create_grand
	echo "Multiple databases created"
	show_created_databases
	echo "  Finish work ------------------------------------------------------------------"
fi
