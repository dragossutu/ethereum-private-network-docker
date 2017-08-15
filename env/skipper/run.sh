#!/usr/bin/env bash

set -e

cd "$(dirname "${BASH_SOURCE[0]}")"

./cleanup.sh

docker network create \
    --label project=eth-dapp-dev \
    --subnet 172.20.0.0/16 \
    eth-dev-network

./run-miner.sh
