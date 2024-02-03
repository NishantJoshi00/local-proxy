#!/bin/bash

# check if a container with the same name is already running
if [ "$(docker ps -q -f name=nginx-proxy)" ]; then
    # stop the running container
    docker stop nginx-proxy
    exit 0
fi

echo "nginx-proxy is not running"
exit 1
