#!/bin/bash

JSON_FILE_PATH="./config.json"
REPOSITORY_OWNER_NAME=$(jq '.repository_owner_name' < $JSON_FILE_PATH)
REPOSITORY_NAME=$(jq '.repository_name' < $JSON_FILE_PATH)

echo "$REPOSITORY_OWNER_NAME"
echo "$REPOSITORY_NAME"

echo -n RUNNER_TOKEN:
read -r RUNNER_TOKEN

echo -n RUNNER_NAME:
read -r RUNNER_NAME

REPOSITORY_URL=https://github.com/$REPOSITORY_OWNER_NAME/$REPOSITORY_NAME
REPOSITORY_URL="${REPOSITORY_URL//\"/}"
echo "$REPOSITORY_URL"

## note: runnerを稼働させるコンテナを作成する
docker build -t actions-builder .
CONTAINER_ID=$(docker run -it --name "$RUNNER_NAME" -d actions-builder)
docker exec -i "$CONTAINER_ID" ./config.sh --url "$REPOSITORY_URL" --token "$RUNNER_TOKEN"
docker exec -d "$CONTAINER_ID" ./run.sh