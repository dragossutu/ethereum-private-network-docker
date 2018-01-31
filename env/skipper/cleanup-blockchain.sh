#!/usr/bin/env bash

set -e

scriptDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dataDir="${scriptDir}/../data"

rm --force --recursive --verbose ${dataDir}/eth*
mkdir --parents --verbose ${dataDir}/{ethash,ethereum/keystore}
