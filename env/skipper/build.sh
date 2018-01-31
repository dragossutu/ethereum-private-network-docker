#!/usr/bin/env bash

set -e

scriptDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "${scriptDir}/../docker/geth"
docker image build --tag drgsutu/ethereum-client-go:alpine .
docker image prune --force
