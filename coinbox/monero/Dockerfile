ARG ALPINE_VER=3.12
ARG DEBIAN_VER=9-slim
################################################################################
# Source
################################################################################
FROM alpine:${ALPINE_VER} AS source

ENV BASE_DIR /monero

RUN apk add --update curl

ENV MONERO_VER=0.16.0.3
ENV MONERO_URL=https://github.com/monero-project/monero/releases/download/v${MONERO_VER}/monero-linux-x64-v${MONERO_VER}.tar.bz2
RUN mkdir ${BASE_DIR}
RUN curl -sSL ${MONERO_URL} \
       | tar --strip-components=2 -xvjf - -C ${BASE_DIR}

################################################################################
# Runtime
################################################################################
FROM debian:${DEBIAN_VER}

COPY --from=source /monero /usr/local/bin

VOLUME ["/var/lib/monero"]
EXPOSE 18080 18081
ENTRYPOINT ["/usr/local/bin/monerod", "--data-dir=/var/lib/monero"]
