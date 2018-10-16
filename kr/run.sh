#!/bin/bash
CONFIG_PATH=/data/options.json

HASSIP=$(jq --raw-output ".hass_ip" $CONFIG_PATH)
HASSPORT=$(jq --raw-output ".hass_port" $CONFIG_PATH)
CLOUDUSERNAME=$(jq --raw-output ".cloud_username" $CONFIG_PATH)
CLOUDPASSWORD=$(jq --raw-output ".cloud_password" $CONFIG_PATH)
LISTENPORT=$(jq --raw-output ".listen_port" $CONFIG_PATH)

HASS_CONFIG_FILE=.config/hass.json
CLOUD_CONFIG_FILE=.config/cloud.json
USER_CONFIG_FILE=.config/config.json

jq -n -c -M --arg v "$HASS_CONFIG_FILE" '{"ip":"$HASSIP","port":$HASSPORT}'
jq -n -c -M --arg v "$CLOUD_CONFIG_FILE" '{"username":"$CLOUDUSERNAME","password":"$CLOUDPASSWORD"}'

if [ $LISTENPORT ]; then
  jq -n -c -M --arg v "$USER_CONFIG_FILE" '{"listen": $LISTENPORT}'
fi

# Startup
./kr
