#!/usr/bin/env bash

set -e

currentDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
blockchainDataDir="${currentDir}/../blockchainData/local"

docker container run \
    --interactive \
    --name geth-console \
    --label project=eth-private-network \
    --rm \
    --tty \
    --user $(id --user):$(id --group) \
    --volume "${blockchainDataDir}/ethash":/tmp/.ethash \
    --volume "${blockchainDataDir}/ethereum":/tmp/.ethereum \
    drgsutu/ethereum-client-go:alpine attach ipc:/tmp/.ethereum/geth.ipc
