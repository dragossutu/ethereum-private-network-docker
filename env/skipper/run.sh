#!/usr/bin/env bash

set -e

cd "$(dirname "${BASH_SOURCE[0]}")"

./cleanup-docker.sh

docker network create \
    --label project=eth-private-network \
    --subnet 172.20.0.0/16 \
    eth-private-network

./run-miner.sh
