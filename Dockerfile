FROM java:7

ENV SERVER_TYPE cauldron

RUN mkdir -p /mc/bin && mkdir -p /data/world \
	&& curl -o /mc/bin/server.jar -SLO "http://download.sellmoe.ml/cauldron-1.7.10-1.1207.01.198-server.jar" \
	&& curl -o /tmp/libraries.zip -SLO "http://download.sellmoe.ml/libraries-1.1207.01.zip" \
	&& unzip -d /mc/bin /tmp/libraries.zip \
	&& rm "/tmp/libraries.zip"

ADD scripts/* /mc/scripts/
RUN chmod +x /mc/scripts/* \
	&& groupadd -g 25565 minecraft \
	&& useradd -s /bin/bash -u 25565 -g 25565 minecraft \
	&& chown -R minecraft:minecraft /data/world

EXPOSE 25565

USER minecraft
WORKDIR /data/world
ENTRYPOINT ["/mc/scripts/run-mc"]
