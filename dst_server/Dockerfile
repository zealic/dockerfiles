FROM debian:jessie
MAINTAINER zealic <zealic@gmail.com>

RUN dpkg --add-architecture i386 && apt-get update \
  && apt-get install -y curl lib32gcc1 lib32stdc++6 libgcc1 libcurl4-gnutls-dev:i386 \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd -u 10999 -m steam
RUN mkdir /DST \
  && chown steam:steam /DST \
  && mkdir -p /home/steam/.klei \
  && chown -R steam:steam /home/steam/.klei

USER steam
RUN mkdir ~/steamcmd
# Visit: http://steamcommunity.com/games/322330/announcements/
# Update DST_SERVER_VERSION to force build new docker image
ENV DST_SERVER_VERSION 188845
RUN cd  ~/steamcmd && curl -SLO "http://media.steampowered.com/installer/steamcmd_linux.tar.gz" \
  && tar -xvf steamcmd_linux.tar.gz -C ~/steamcmd && rm steamcmd_linux.tar.gz
RUN ~/steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/steam/steamapps/DST +app_update 343050 validate +quit

USER root
ADD ./bin/* /usr/local/bin/
RUN chmod +x /usr/local/bin/run-dst

USER steam
EXPOSE 10999/udp
VOLUME ["/DST"]
ENTRYPOINT ["/usr/local/bin/run-dst"]
