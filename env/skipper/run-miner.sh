#!/usr/bin/env bash

set -e

currentDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dataDir="${currentDir}/../data"

minerIPAddress=${1:-172.20.0.2}

# make sure blockchain data dir exists, else Docker will create it with root as owner
mkdir --parents --verbose ${dataDir}/{ethash,ethereum}

# Run Geth node
docker container run \
    --detach \
    --ip ${minerIPAddress} \
    --label project=eth-private-network \
    --name geth-miner \
    --network eth-private-network \
    --user $(id --user):$(id --group) \
    --volume "${dataDir}/ethash":/tmp/.ethash \
    --volume "${dataDir}/ethereum":/tmp/.ethereum \
    drgsutu/ethereum-client-go:alpine \
        --identity "dev-miner" \
        --ipcdisable \
        --mine \
        --minerthreads 1 \
        --password /password.txt \
        --rpc \
        --unlock 0,1,2
