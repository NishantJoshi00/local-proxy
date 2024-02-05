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

if ! awk -F: '{print $2}' < ./conf.d/upstream.conf | grep -w "$PORT"
then
    echo -e "Port $PORT is not running"
    exit 1
fi

# remove the port from the upstream.conf file

cp ./conf.d/upstream.conf ./conf.d/upstream.conf.bak
grep -v -w "$PORT" ./conf.d/upstream.conf.bak > ./conf.d/upstream.conf

# reload the nginx configuration

docker exec -it nginx-proxy nginx -s reload
