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

jq -n -c -M --arg ip "$HASSIP" --argjson port $HASSPORT '{"ip":$ip,"port":$port}' > $HASS_CONFIG_FILE
jq -n -c -M --arg name "$CLOUDUSERNAME" --arg passwd "$CLOUDPASSWORD" '{"username":$name,"password":$passwd}' > $CLOUD_CONFIG_FILE


if [ $LISTENPORT ]; then
  jq -n -c -M --argjson v $LISTENPORT '{"listen": $v}' > $USER_CONFIG_FILE
fi

# Create /share/habridge/data folder
if [ ! -d /share/kr ]; then
  echo "Creating /share/kr folder. Run code here"
  mkdir -p /share/kr
  cp -r .config /share/kr
  cp -r src /share/kr
  cp -r /root/kr /share/kr/
fi


# Startup
/share/kr/kr
