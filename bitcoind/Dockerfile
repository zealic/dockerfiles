FROM debian:wheezy

ENV BITCOIND_VERSION 0.12.1

RUN apt-get update && apt-get install -y curl \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -LsS https://bitcoin.org/bin/bitcoin-core-${BITCOIND_VERSION}/bitcoin-${BITCOIND_VERSION}-linux64.tar.gz | tar -xzf - -C /tmp \
  && chown -R root:root /tmp/bitcoin-* \
  && mv /tmp/bitcoin-*/bin/bitcoin-cli /usr/local/bin \
  && mv /tmp/bitcoin-*/bin/bitcoind /usr/local/bin \
  && mv /tmp/bitcoin-*/bin/test_bitcoin /usr/local/bin \
  && rm -rf /tmp/bitcoin-*

RUN groupadd -r bitcoind \
  && useradd -c "Bitcoind" -d /var/lib/bitcoind -g bitcoind -m -r -s /sbin/nologin bitcoind \
  && rm /var/lib/bitcoind/.bash*

ENV HOME /var/lib/bitcoind

USER bitcoind

EXPOSE 8332 8333 18332 18333

VOLUME ["/var/lib/bitcoind"]

ENTRYPOINT ["/usr/local/bin/bitcoind"]
