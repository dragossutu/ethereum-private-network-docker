#!/usr/bin/env bash

set -e

currentDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dataDir="${currentDir}/../data"

rm --force --recursive --verbose ${dataDir}/eth*
mkdir --parents --verbose ${dataDir}/{ethash,ethereum/keystore}
