#!/usr/bin/env bash

set -e

currentDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
blockchainDataDir="${currentDir}/../blockchainData/local"

rm --force --recursive --verbose ${blockchainDataDir}/eth*
mkdir --parents --verbose ${blockchainDataDir}/{ethash,ethereum/keystore}
