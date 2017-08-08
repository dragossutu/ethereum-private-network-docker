FROM ethereum/client-go:alpine

RUN apk add --update jq

COPY ["config.toml", "password.txt", "/"]
COPY ["customGenesis.json", "/customGenesisExample.json"]
COPY docker-entrypoint.sh /entrypoint.sh

# create accounts and initialize blockchain if there are no accounts created
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/geth", "--config", "config.toml"]
