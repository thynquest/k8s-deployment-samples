#!/bin/bash

status_code=200
while [ $status_code -eq 200 ]
do
    sleep 1.5
    status_code=$(curl --write-out %{http_code} --silent --output /dev/null http://localhost:8080)
    if [[ "$status_code" -ne 200 ]] ; then
        echo "Site status changed to $status_code"
    else
        echo "Site ok"
    fi
done