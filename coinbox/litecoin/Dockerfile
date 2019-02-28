################################################################################
# Source
################################################################################
FROM alpine:edge AS source

ENV BASE_DIR /litecoin

RUN apk add --update curl

ENV LITECOIN_VERSION 0.16.3
ENV LITECOIN_BINARY_URL https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz
RUN mkdir ${BASE_DIR}
RUN curl -sSL ${LITECOIN_BINARY_URL} \
        | tar --strip-components=1 -xzf - -C ${BASE_DIR}


################################################################################
# Runtime
################################################################################
FROM debian:stretch-slim

COPY --from=source /litecoin/bin /usr/local/bin

VOLUME ["/var/lib/litecoin"]
EXPOSE 8332 8333 18332 18333
ENTRYPOINT ["/usr/local/bin/litecoind", "-printtoconsole", "-datadir=/var/lib/litecoin"]
