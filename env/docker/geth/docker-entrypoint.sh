#!/bin/sh

set -uo pipefail

numberOfAccounts=${NUMBER_OF_ACCOUNTS:-2}
keystoreDir='/tmp/.ethereum/keystore'
outputFormat="\n**** %s\n"

# if command starts with an option, prepend executable /geth
if [ "${1}" != "/geth" ]; then
	set -- /geth --config config.toml "$@"
fi

if [ ! -d '/tmp/.ethereum/geth/chaindata' ]; then
    printf "$outputFormat" "Initializing genesis block"
    /geth --config config.toml init /customGenesis.json
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
fi

printf "$outputFormat" "Running container CMD"
exec "$@"
