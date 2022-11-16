#!/bin/bash

status_code=200
URL="http://localhost:8080"
while [ $status_code -eq 200 ]
do
    sleep 1.5
    response=$(curl -s -w "%{http_code}" $URL)
    http_code=$(tail -n1 <<< "$response")
    if [[ "$http_code" -ne 200 ]] ; then
        echo "Site is not up status is $status_code"
    else
        content=$(sed '$ d' <<< "$response")
        echo $content
    fi
done