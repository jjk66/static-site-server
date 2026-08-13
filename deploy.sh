#!/usr/bin/env bash

# deploy script to push out the static site server to a remote server via SSH

# Configuration variables
REMOTE_USER="root"
REMOTE_HOST="localhost"
REMOTE_PORT="2222"
LOCAL_DIR="./simple-static-site"
REMOTE_DIR="/var/www/html"
IDENTITY_FILE="~/.ssh/test_key_1"  # Path to your private key for SSH authentication

echo "Deploying static site to $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR"

/usr/bin/rsync -avz --delete -e "ssh -p $REMOTE_PORT -i $IDENTITY_FILE" "$LOCAL_DIR/" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR"

if [ $? -eq 0 ]; then
    echo "Deployment successful!"
else
    echo "Deployment failed!"
fi