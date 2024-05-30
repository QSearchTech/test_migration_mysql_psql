#!/bin/bash

INSTANCE_NAME="psql-migrate"
PROJECT_ID="master-experiment"
BUCKET_ID="test_qsh_cloud_sql_migration"
INFILE="db_list.txt"

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


# ceate db and import sql
for DATABASE_NAME in $(cat "$INFILE")
  do
    echo "DATABASE_NAME: $DATABASE_NAME"
    if [[ ${EXISTING_DATABASES_ARRAY[@]} =~ $DATABASE_NAME ]]
    then
      echo "$DATABASE_NAME already exists, skipping creation."
    else
      echo "Create db"
      gcloud sql databases create $DATABASE_NAME --instance="$INSTANCE_NAME" --project="$PROJECT_ID"
    fi
    echo "Import sql"
    gcloud sql import sql $INSTANCE_NAME gs://$BUCKET_ID/$DATABASE_NAME.sql --database="$DATABASE_NAME" --project="$PROJECT_ID"
  done

echo "Finish!"