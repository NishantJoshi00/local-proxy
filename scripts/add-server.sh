#!/bin/bash

set -e

PORT=$1

if [ -z "$PORT" ]
then
    echo -e "Please provide a port number"
    exit 1
fi

if ! [[ $PORT =~ ^[0-9]+$ ]]
then
    echo -e "Port must be a number"
    exit 1
fi


if awk -F: '{print $2}' < ./conf.d/upstream.conf | grep -w "$PORT"
then
    echo -e "Port is already in use"
    exit 1
fi

echo -e "Adding port $PORT to the upstream.conf file"

echo "server 0.0.0.0:$PORT;" >> ./conf.d/upstream.conf

echo -e "Reloading Nginx"

docker exec -it nginx-proxy nginx -s reload | true
