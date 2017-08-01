#!/usr/bin/env bash

set -e

currentDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
blockchainTestData="${currentDir}/../blockchainTestData/local"

# Run Geth miner
docker container run \
    --interactive \
    --name geth-miner \
    --rm \
    --tty \
    --user $(id -u):$(id -g) \
    --volume ${blockchainTestData}:/tmp/blockchainData \
    drgsutu/ethereum-client-go:alpine --mine --minerthreads=4
