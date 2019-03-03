ARG ALPINE_VER=3.9
################################################################################
# Source
################################################################################
FROM alpine:${ALPINE_VER} AS source-bx

ENV BASE_DIR /bitcoin

RUN apk add --no-cache curl

ENV BITCOIN_VER=0.17.1
ENV BITCOIN_URL=https://bitcoin.org/bin/bitcoin-core-${BITCOIN_VER}/bitcoin-${BITCOIN_VER}-x86_64-linux-gnu.tar.gz
RUN mkdir ${BASE_DIR}
RUN curl -sSL ${BITCOIN_URL} \
        | tar --strip-components=1 -xzf - -C ${BASE_DIR}

ENV BX_VER 3.2.0
ENV BX_URL https://github.com/libbitcoin/libbitcoin-explorer/releases/download/v${BX_VER}/bx-linux-x64-qrcode
RUN curl -sSL -o ${BASE_DIR}/bin/bx ${BX_URL} \
    && chmod +x ${BASE_DIR}/bin/bx


################################################################################
# Source
################################################################################
FROM buildpack-deps:stretch AS source-vanitygen
RUN apt-get update && apt-get install -y libssl1.0-dev
ENV VANITYGEN_PLUS_VER=1.53
ENV VANITYGEN_PLUS_VER_PREFIX=PLUS
ENV VANITYGEN_PLUS_REPO=https://github.com/exploitagency/vanitygen-plus.git
ENV VANITYGEN_PLUS_DIR=/vanitygen-plus
RUN mkdir $VANITYGEN_PLUS_DIR
WORKDIR $VANITYGEN_PLUS_DIR
RUN git init \
  && git remote add origin $VANITYGEN_PLUS_REPO \
  && git fetch --depth 1 origin $VANITYGEN_PLUS_VER_PREFIX$VANITYGEN_PLUS_VER \
  && git reset --hard FETCH_HEAD

RUN make


################################################################################
# Runtime
################################################################################
FROM debian:stretch-slim

COPY --from=source-bx        /bitcoin/bin    /usr/local/bin
COPY --from=source-vanitygen /vanitygen-plus/vanitygen /usr/local/bin

RUN apt-get update && apt-get install -y libssl1.0 \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

VOLUME ["/var/lib/bitcoin"]
EXPOSE 8332 8333 18332 18333
ENTRYPOINT ["/usr/local/bin/bitcoind", "-printtoconsole", "-datadir=/var/lib/bitcoin"]
