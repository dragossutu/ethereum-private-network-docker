FROM ethereum/client-go:alpine

COPY ["customGenesis.json", "config.toml", "/"]

ENTRYPOINT ["/geth", "--config", "config.toml"]
