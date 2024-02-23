#!/bin/bash


current_date=$(date)


echo "Current date and time: $current_date"


docker run --rm -v "$(pwd)/date.txt:/usr/src/app/date.txt" -e ENTRYPOINT_FILE=/usr/src/app/date.txt nodejs-app


if [ $? -eq 0 ]; then
    
    echo "ENTRYPOINT /usr/src/app/date.txt" >> Dockerfile
    echo "ENTRYPOINT set as /usr/src/app/date.txt in Dockerfile"
else
    echo "Container failed to run"
fi
