#!/bin/bash



# print the status of the container and if it is running, print the logs for nginx-proxy

docker ps | grep nginx-proxy | awk '{print $7}' | while read -r line; do
    if [ "$line" == "Up" ]; then
        docker logs nginx-proxy
        exit 0
    else
        echo -e "\e[31mnginx-proxy is not running\e[0m"
        exit 1
    fi
done

if [[ $? -ne 0 ]]; then
    echo -e "\e[31mnginx-proxy is not running\e[0m"
    exit 1
fi
