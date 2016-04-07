FROM java:7

ENV SERVER_TYPE cauldron
ENV SERVER_MAJOR 1.7.10
ENV SERVER_MINOR 1.1388.1.0

RUN groupadd -g 25565 minecraft \
	&& useradd -m -s /bin/bash -u 25565 -g 25565 minecraft \
	&& mkdir -p mkdir -p /home/minecraft/bin \
	&& curl -o /home/minecraft/bin/server.jar -SLO "http://downloads.sourceforge.net/project/cauldron-unofficial/$SERVER_MAJOR/cauldron-$SERVER_MAJOR-$SERVER_MINOR-server.jar" \
	&& curl -o /tmp/libraries.zip -SLO "http://downloads.sourceforge.net/project/cauldron-unofficial/$SERVER_MAJOR/libraries-$SERVER_MINOR.zip" \
	&& unzip -d /home/minecraft/bin /tmp/libraries.zip \
	&& rm "/tmp/libraries.zip"

ADD scripts/* /home/minecraft/scripts/
RUN mkdir -p /home/minecraft/scripts \
	&& chmod +x /home/minecraft/scripts/* \
	&& mkdir -p /home/minecraft/world \
	&& touch /home/minecraft/world/README.md \
	&& chown -R minecraft:minecraft /home/minecraft/world

# For minecraft user
USER minecraft

EXPOSE 25565
WORKDIR /home/minecraft/world
ENTRYPOINT ["/home/minecraft/scripts/run-mc"]
