#!/usr/bin/env bash

set -e

currentDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
blockchainTestData="${currentDir}/../blockchainTestData/local"

# Cleanup
if docker inspect geth >& /dev/null; then
    docker rm --force --volumes geth
fi
docker system prune --force

# Initialize blockchain
docker run \
    --rm \
    --tty \
    --user $(id -u):$(id -g) \
    --volume ${blockchainTestData}:/tmp/blockchainData \
    drgsutu/ethereum-client-go:alpine init customGenesis.json

# Run Geth node
docker run \
    --detach \
    --name geth \
    --user $(id -u):$(id -g) \
    --volume ${blockchainTestData}:/tmp/blockchainData \
    drgsutu/ethereum-client-go:alpine
