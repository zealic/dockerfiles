ARG ALPINE_VER=3.15
ARG DEBIAN_VER=11-slim
################################################################################
# Source
################################################################################
FROM alpine:${ALPINE_VER} AS source-bx

ENV BASE_DIR /bitcoin

RUN apk add --no-cache curl

ENV BITCOIN_VER=22.0
ENV BITCOIN_URL=https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VER}/bitcoin-${BITCOIN_VER}-x86_64-linux-gnu.tar.gz
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
FROM buildpack-deps:bullseye AS source-vanitygen
RUN apt-get update && apt-get install -y libssl-dev
ENV VANITYGEN_VER=0.1.0
ENV VANITYGEN_REPO=https://github.com/10gic/vanitygen-plusplus.git
ENV VANITYGEN_DIR=/vanitygen-plusplus
RUN mkdir $VANITYGEN_DIR
WORKDIR $VANITYGEN_DIR
RUN git init \
  && git remote add origin $VANITYGEN_REPO \
  && git fetch --depth 1 origin v$VANITYGEN_VER \
  && git reset --hard FETCH_HEAD

RUN make
RUN mv $VANITYGEN_DIR/vanitygen++ /usr/local/bin/vanitygen


################################################################################
# Runtime
################################################################################
FROM debian:${DEBIAN_VER}

COPY --from=source-bx        /bitcoin/bin    /usr/local/bin
COPY --from=source-vanitygen /usr/local/bin/vanitygen /usr/local/bin

RUN apt-get update && apt-get install -y libssl1.1 \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

VOLUME ["/var/lib/bitcoin"]
EXPOSE 8332 8333 18332 18333
ENTRYPOINT ["/usr/local/bin/bitcoind", "-printtoconsole", "-datadir=/var/lib/bitcoin"]
