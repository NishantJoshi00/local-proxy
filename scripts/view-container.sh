#!/bin/bash


docker ps -f name=nginx-proxy | grep nginx-proxy

if [[ $? -ne 0 ]]; then
    echo -e "nginx-proxy is not running"
    exit 1
fi

docker logs nginx-proxy --details
