#!/bin/bash

# Configuration variables
RAINLOOP_DOMAIN="rainloop.lan"
RAINLOOP_NAME="rainloop-mail-client"
LETSENCRYPT_EMAIL="foo@bar.mail"
MAILSERVER_NAME="mail-server"

# Install Rainloop client
echo ">> Running Rainloop Mail Client..."
docker run \
    -d \
    --name="$RAINLOOP_NAME" \
    --restart=always \
    --link="$MAILSERVER_NAME:mail-server" \
    -e "VIRTUAL_HOST=$RAINLOOP_DOMAIN" \
    -e "LETSENCRYPT_HOST=$RAINLOOP_DOMAIN" \
    -e "LETSENCRYPT_EMAIL=$LETSENCRYPT_EMAIL" \
    runningman84/rainloop &>/dev/null

# Wait until the docker is up and running
echo -n ">> Waiting for Rainloop Mail Client to start..."
while [ ! $(docker top $RAINLOOP_NAME &>/dev/null && echo $?) ]
do
    echo -n "."
    sleep 0.5
done
echo "started!"

# Print friendly done message
echo "-----------------------------------------------------"
echo "All right! Everything seems to be installed correctly. Have a nice day!"
echo ">> Admin URL: https://${RAINLOOP_DOMAIN}/?admin"
echo ">> User URL: https://${RAINLOOP_DOMAIN}/"
echo ">> Default login is \"admin\", password is \"12345\""
echo ">> Server hostname is \"mail-server\""
echo "-----------------------------------------------------"