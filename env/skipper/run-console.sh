#!/usr/bin/env bash

set -e

currentDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
blockchainTestData="${currentDir}/../blockchainTestData/local"

docker container run \
    --interactive \
    --name geth-console \
    --ipc container:geth \
    --label project=eth-private-network \
    --rm \
    --tty \
    --user $(id --user):$(id --group) \
    --volume "${blockchainTestData}/ethash":/tmp/.ethash \
    --volume "${blockchainTestData}/ethereum":/tmp/.ethereum \
    drgsutu/ethereum-client-go:alpine attach ipc:/tmp/.ethereum/geth.ipc
