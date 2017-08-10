#!/bin/sh

set -uo pipefail

numberOfAccounts=${NUMBER_OF_ACCOUNTS:-4}
keystoreDir='/tmp/.ethereum/keystore'
outputFormat="\n**** %s\n"

# if command starts with an option, prepend executable /geth
if [ "${1}" != "/geth" ]; then
	set -- /geth --config config.toml "$@"
fi

# make sure keystore dir exists
if [ -d "$keystoreDir" ]; then
    mkdir -p ${keystoreDir}
fi

if [ ! "$(ls -A ${keystoreDir})" ]; then
    printf "$outputFormat" "Creating accounts"
    while [ "$numberOfAccounts" -gt 0 ]; do
        /geth --config config.toml account new --password password.txt
        let "numberOfAccounts=numberOfAccounts-1"
    done

    # temporary hack to fix user privileges problems
    cp /customGenesisExample.json /tmp/customGenesis.json

    printf "$outputFormat" "Adding accounts to genesis block json"
    for f in $(ls ${keystoreDir}); do
        address=$(jq -r '.address' "$keystoreDir/$f")
        jq --arg address $address '.alloc += {($address):{"balance":"20000000000000000000"}}' /tmp/customGenesis.json > /tmp/tmpCustomGenesis.json
        mv /tmp/tmpCustomGenesis.json /tmp/customGenesis.json
    done

    printf "$outputFormat" "**** Initializing genesis block"
    /geth --config config.toml init /tmp/customGenesis.json
fi

printf "$outputFormat" "Running container CMD"
exec "$@"
