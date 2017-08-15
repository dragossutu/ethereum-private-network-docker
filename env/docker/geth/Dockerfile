FROM ethereum/client-go:alpine

RUN apk add --update jq

COPY ["config.toml", "customGenesis.json", "password.txt", "/"]
COPY docker-entrypoint.sh /entrypoint.sh

# create accounts and initialize blockchain if there are no accounts created
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/geth", "--config", "config.toml"]
