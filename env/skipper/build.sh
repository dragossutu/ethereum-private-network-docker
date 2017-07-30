#!/usr/bin/env bash

set -e

currentDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "${currentDir}/../docker/geth"
docker build --tag drgsutu/ethereum-client-go:alpine .
