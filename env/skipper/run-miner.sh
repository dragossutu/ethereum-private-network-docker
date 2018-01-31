#!/usr/bin/env bash

set -e

currentDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
blockchainDataDir="${currentDir}/../blockchainData/local"

minerIPAddress=${1:-172.20.0.2}

# make sure blockchain data dir exists, else Docker will create it with root as owner
mkdir --parents --verbose ${blockchainDataDir}/{ethash,ethereum}

# Run Geth node
docker container run \
    --detach \
    --ip ${minerIPAddress} \
    --label project=eth-private-network \
    --name geth-miner \
    --network eth-private-network \
    --user $(id --user):$(id --group) \
    --volume "${blockchainDataDir}/ethash":/tmp/.ethash \
    --volume "${blockchainDataDir}/ethereum":/tmp/.ethereum \
    drgsutu/ethereum-client-go:alpine \
        --identity "dev-miner" \
        --ipcdisable \
        --mine \
        --minerthreads 1 \
        --password /password.txt \
        --rpc \
        --unlock 0,1,2
