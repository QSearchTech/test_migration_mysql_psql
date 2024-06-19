#!/bin/bash

INSTANCE_NAME="psql-migrate"
PROJECT_ID="master-experiment"
INFILE="db_list.txt"
MYSQL_HOST="34.42.234.145"
MYSQL_USER="qsh"
MYSQL_PASSWORD="Q/VMy)Xj2[\I_|Jx"
PSQL_HOST="34.30.173.48"
PSQL_USER="postgres"
PSQL_PASSWORD="LwejnHswdj"


# check db_list.txt
if [ ! -f $INFILE ]; then
  echo "INFILE error: $INFILE does not exist."
  exit 1
fi

# list existing db
EXISTING_DATABASES=$(gcloud sql databases list --instance="$INSTANCE_NAME" --format="value(name)" --project="$PROJECT_ID")
EXISTING_DATABASES_ARRAY=()
for db in $EXISTING_DATABASES
  do
    EXISTING_DATABASES_ARRAY+=("$db")
  done
echo "EXISTING_DATABASES_ARRAY: ${EXISTING_DATABASES_ARRAY[@]}"


# ceate and migrate db
for DATABASE_NAME in $(cat "$INFILE")
  do
    echo "DATABASE_NAME: $DATABASE_NAME"
    if [[ ${EXISTING_DATABASES_ARRAY[@]} =~ $DATABASE_NAME ]]
    then
      echo "$DATABASE_NAME already exists, skipping creation."
    else
      echo "Create $DATABASE_NAME"
      gcloud sql databases create $DATABASE_NAME --instance="$INSTANCE_NAME" --project="$PROJECT_ID"
      ./pgloader/build/bin/pgloader mysql://$MYSQL_USER:$MYSQL_PASSWORD@$MYSQL_HOST/$DATABASE_NAME pgsql://$PSQL_USER:$PSQL_PASSWORD@$PSQL_HOST/$DATABASE_NAME
    fi
  done

echo "Finish!"