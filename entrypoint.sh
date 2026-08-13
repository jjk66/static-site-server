#!/bin/bash

# Start SSH server
echo "Starting SSH server..."
/usr/sbin/sshd

# Start Nginx in the foreground so the container stays active
echo "Starting Nginx server..."
nginx -g "daemon off;"
