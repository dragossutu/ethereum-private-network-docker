#!/usr/bin/env bash

set -e

currentDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
blockchainTestData="${currentDir}/../blockchainTestData/local"

# Cleanup
if docker container inspect geth >& /dev/null; then
    docker container rm --force --volumes geth
fi
docker system prune --force

# Initialize blockchain
docker container run \
    --rm \
    --tty \
    --user $(id -u):$(id -g) \
    --volume ${blockchainTestData}:/tmp/blockchainData \
    drgsutu/ethereum-client-go:alpine init customGenesis.json

# Run Geth node
docker container run \
    --detach \
    --name geth \
    --user $(id -u):$(id -g) \
    --volume ${blockchainTestData}:/tmp/blockchainData \
    drgsutu/ethereum-client-go:alpine
