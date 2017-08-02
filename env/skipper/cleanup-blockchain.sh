#!/usr/bin/env bash

set -e

currentDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
blockchainTestData="${currentDir}/../blockchainTestData/local"

rm --force --recursive ${blockchainTestData}/eth*
mkdir -p "$blockchainTestData/ethereum/keystore"
mkdir -p "$blockchainTestData/ethash"
