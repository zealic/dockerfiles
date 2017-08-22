################################################################################
# Source
################################################################################
FROM alpine:edge AS source

ENV BASE_DIR /bitcoin

RUN apk add --update curl

ENV BITCOIND_VERSION 0.14.2
ENV BITCOIN_BINARY_URL https://bitcoin.org/bin/bitcoin-core-${BITCOIND_VERSION}/bitcoin-${BITCOIND_VERSION}-x86_64-linux-gnu.tar.gz
RUN mkdir ${BASE_DIR}
RUN curl -sSL ${BITCOIN_BINARY_URL} \
        | tar --strip-components=1 -xzf - -C ${BASE_DIR}

ENV BX_VERSION 3.2.0
ENV BX_BINARY_URL https://github.com/libbitcoin/libbitcoin-explorer/releases/download/v${BX_VERSION}/bx-linux-x64-qrcode
RUN curl -sSL -o ${BASE_DIR}/bin/bx ${BX_BINARY_URL} \
    && chmod +x ${BASE_DIR}/bin/bx


################################################################################
# Runtime
################################################################################
FROM debian:stretch-slim

COPY --from=source /bitcoin/bin /usr/local/bin

VOLUME ["/var/lib/bitcoin"]
EXPOSE 8332 8333 18332 18333
ENTRYPOINT ["/usr/local/bin/bitcoind", "-datadir=/var/lib/bitcoin"]
