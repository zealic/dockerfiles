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
ENV DST_SERVER_VERSION 138964
RUN cd  ~/steamcmd && curl -SLO "http://media.steampowered.com/installer/steamcmd_linux.tar.gz" \
  && tar -xvf steamcmd_linux.tar.gz -C ~/steamcmd && rm steamcmd_linux.tar.gz
RUN echo "login anonymous\nforce_install_dir /home/steam/steamapps/DST\napp_update 343050 validate\nquit\n" | ~/steamcmd/steamcmd.sh

USER root
ADD ./bin/* /usr/local/bin/
RUN chmod +x /usr/local/bin/run-dst

USER steam
EXPOSE 10999/udp
VOLUME ["/DST"]
ENTRYPOINT ["/usr/local/bin/run-dst"]
