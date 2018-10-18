#!/bin/bash
CONFIG_PATH=/data/options.json

CLOUDUSERNAME=$(jq --raw-output ".cloud_username" $CONFIG_PATH)
CLOUDPASSWORD=$(jq --raw-output ".cloud_password" $CONFIG_PATH)
LISTENPORT=$(jq --raw-output ".listen_port" $CONFIG_PATH)

CLOUD_CONFIG_FILE=/data/.config/cloud.json
USER_CONFIG_FILE=/data/.config/config.json

jq -n -c -M --arg name "$CLOUDUSERNAME" --arg passwd "$CLOUDPASSWORD" '{"username":$name,"password":$passwd}' > $CLOUD_CONFIG_FILE
if [ $LISTENPORT ]; then
  jq -n -c -M --argjson v $LISTENPORT '{"listen": $v}' > $USER_CONFIG_FILE
fi

# Startup
./kr -P '/data/'
