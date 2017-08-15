#!/usr/bin/env bash

set -e

currentDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
blockchainTestData="${currentDir}/../blockchainTestData/local"

# Run Geth node
docker container run \
    --detach \
    --ip 172.20.0.2 \
    --label project=eth-dapp-dev \
    --name geth \
    --network eth-dev-network \
    --user $(id --user):$(id --group) \
    --volume "${blockchainTestData}/ethash":/tmp/.ethash \
    --volume "${blockchainTestData}/ethereum":/tmp/.ethereum \
    drgsutu/ethereum-client-go:alpine --mine --minerthreads 1
