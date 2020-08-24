ARG ALPINE_VER=3.12
ARG DEBIAN_VER=9-slim
################################################################################
# Source
################################################################################
FROM alpine:${ALPINE_VER} AS source

ENV BASE_DIR /litecoin

RUN apk add --update curl

ENV LITECOIN_VER=0.18.1
ENV LITECOIN_URL=https://download.litecoin.org/litecoin-${LITECOIN_VER}/linux/litecoin-${LITECOIN_VER}-x86_64-linux-gnu.tar.gz
RUN mkdir ${BASE_DIR}
RUN curl -sSL ${LITECOIN_URL} \
        | tar --strip-components=1 -xzf - -C ${BASE_DIR}


################################################################################
# Runtime
################################################################################
FROM debian:${DEBIAN_VER}

COPY --from=source /litecoin/bin /usr/local/bin

VOLUME ["/var/lib/litecoin"]
EXPOSE 8332 8333 18332 18333
ENTRYPOINT ["/usr/local/bin/litecoind", "-printtoconsole", "-datadir=/var/lib/litecoin"]
