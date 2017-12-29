#!/usr/bin/env bash

set -e

currentDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
blockchainDataDir="${currentDir}/../blockchainData/local"

# Run Geth node
docker container run \
    --detach \
    --ip 172.20.0.2 \
    --label project=eth-private-network \
    --name geth-miner \
    --network eth-private-network \
    --user $(id --user):$(id --group) \
    --volume "${blockchainDataDir}/ethash":/tmp/.ethash \
    --volume "${blockchainDataDir}/ethereum":/tmp/.ethereum \
    drgsutu/ethereum-client-go:alpine --mine --minerthreads 1 --rpc --rpcaddr "0.0.0.0"
