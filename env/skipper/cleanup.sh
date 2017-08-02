#!/usr/bin/env bash

docker container ps \
    --all \
    --filter label=project=eth-dev \
    --quiet | xargs --no-run-if-empty docker container rm --force --volumes
