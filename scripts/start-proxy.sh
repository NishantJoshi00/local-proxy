#!/bin/bash

# check if a container with the same name is already running
if [ "$(docker ps -q -f name=nginx-proxy)" ]; then
    echo "A container with the name nginx-proxy is already running. Please stop it first."
    exit 1
fi

# remove any stopped container with the same name
if [ "$(docker ps -aq -f status=exited -f name=nginx-proxy)" ]; then
    docker rm nginx-proxy
fi

docker run -p 8080:8080 -d --net=host -v $(pwd)/:/etc/nginx/ --name nginx-proxy nginx
