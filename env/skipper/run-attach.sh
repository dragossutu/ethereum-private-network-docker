#!/usr/bin/env bash

set -e

docker container run \
    --entrypoint /geth \
    --interactive \
    --name geth-attach \
    --label project=eth-private-network \
    --rm \
    --tty \
    drgsutu/ethereum-client-go:alpine attach http://172.20.0.2:8545
