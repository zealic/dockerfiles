################################################################################
# Source
################################################################################
FROM alpine:edge AS source

ENV BASE_DIR /monero

RUN apk add --update curl

ENV MONERO_VERSION 0.10.3.1
ENV MONERO_BINARY_URL https://github.com/monero-project/monero/releases/download/v${MONERO_VERSION}/monero-linux-x64-v${MONERO_VERSION}.tar.bz2
RUN mkdir ${BASE_DIR}
RUN curl -sSL ${MONERO_BINARY_URL} \
       | tar --strip-components=2 -xvjf - -C ${BASE_DIR}

################################################################################
# Runtime
################################################################################
FROM debian:stretch-slim

COPY --from=source /monero /usr/local/bin

VOLUME ["/var/lib/monero"]
EXPOSE 18080 18081
ENTRYPOINT ["/usr/local/bin/monerod", "--data-dir=/var/lib/monero"]
