#!/bin/bash

set +ae

source ./config.sh

timestamp=$(($(date +%s) / 10 * 10))

for file in queries/*.sql; do
    RESULT=$(mysql -u $DB_USER -p$DB_PASS -h $DB_HOST -P $DB_PORT -e "$(cat $file)" -NB | sed -e 's/\t/,/g')
    JSON=$(echo "${RESULT}" | jq -scR '. | split("\n") | map(split(",")) | map(select(. != [])) | map({name: ($base + "." + .[0]), value: .[1] | tonumber, interval: (if . | length > 2 then (.[2] | tonumber) else 60 end), time: $timestamp | tonumber })' --arg timestamp $timestamp --arg base $(basename $file .sql))

    curl -X POST -u "$GRAPHITE_USER:$GRAPHITE_AUTH" -H "Content-Type: application/json" "$GRAPHITE_ENDPOINT" -d "$JSON"
done

echo $RESULTS

set -ae
