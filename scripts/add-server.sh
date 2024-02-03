#!/bin/bash

set -e

PORT=$1

if [ -z "$PORT" ]
then
    echo -e "\e[31mPlease provide a port number\e[0m"
    exit 1
fi

if ! [[ $PORT =~ ^[0-9]+$ ]]
then
    echo -e "\e[31mPort must be a number\e[0m"
    exit 1
fi


if awk -F: '{print $2}' < ./conf.d/upstream.conf | grep -w "$PORT"
then
    echo -e "\e[31mPort is already in use\e[0m"
    exit 1
fi

echo -e "\e[32mAdding port \e[1m$PORT\e[0m \e[32mto the upstream.conf file\e[0m"

echo "server 0.0.0.0:$PORT;" >> ./conf.d/upstream.conf

echo -e "\e[32mReloading Nginx\e[0m"

docker exec -it nginx-proxy nginx -s reload | true
