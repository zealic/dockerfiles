FROM debian:jessie-slim

ENV PARITY_VERSION 1.7.0
ENV PARITY_MD5SUM 266fe720450bf2e3301c62ab69d647f2

RUN apt-get update && apt-get install -y curl openssl \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -LsS -o /tmp/parity.deb https://parity-downloads-mirror.parity.io/v${PARITY_VERSION}/x86_64-unknown-linux-gnu/parity_${PARITY_VERSION}_amd64.deb \
  && dpkg -i /tmp/parity.deb

ENV HOME /var/lib/parity

EXPOSE 8180 8546

VOLUME ["/var/lib/parity"]

ENTRYPOINT ["/usr/bin/parity"]

CMD [ \
        "-d", "/var/lib/parity", \
        "--ui-interface", "0.0.0.0", \
        "--ws-interface", "0.0.0.0", \
        "ui" \
    ]
