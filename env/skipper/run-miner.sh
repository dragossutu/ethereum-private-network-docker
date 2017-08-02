#!/usr/bin/env bash

set -e

currentDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
blockchainTestData="${currentDir}/../blockchainTestData/local"

# get first address alphabetically
firstAccount=$(ls ${blockchainTestData}/ethereum/keystore/ | head -1)
etherbase="${firstAccount: -40}"

# Run Geth miner
docker container run \
    --interactive \
    --name geth-miner \
    --label project=eth-dapp-dev \
    --rm \
    --tty \
    --volume "${blockchainTestData}/ethash":/tmp/.ethash \
    --volume "${blockchainTestData}/ethereum":/tmp/.ethereum \
    drgsutu/ethereum-client-go:alpine --etherbase ${etherbase} --mine --minerthreads=4
