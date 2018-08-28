ARG BASE_IMAGE=buildpack-deps:stretch-curl
################################################################################
# Source - gomplate
################################################################################
FROM $BASE_IMAGE AS source-gomplate
ENV GOMPLATE_VER=2.7.0
ENV GOMPLATE_URL=https://github.com/hairyhenderson/gomplate/releases/download/v$GOMPLATE_VER/gomplate_linux-amd64
RUN curl -sSL -o /usr/local/bin/gomplate $GOMPLATE_URL
RUN chmod +x /usr/local/bin/gomplate


################################################################################
# Source - Lego
################################################################################
FROM $BASE_IMAGE AS source-lego
ENV LEGO_VER=1.0.1
ENV LEGO_URL=https://github.com/xenolf/lego/releases/download/v$LEGO_VER/lego_linux_amd64.tar.xz
RUN apt-get update && apt-get install -y xz-utils
RUN curl -sSL $LEGO_URL | tar -C /tmp --xz -xvf -
RUN mv /tmp/lego_linux_amd64 /usr/local/bin/lego


################################################################################
# Source - Migrate
################################################################################
FROM $BASE_IMAGE AS source-migrate
ENV MIGRATE_VER=3.4.0
ENV MIGRATE_URL=https://github.com/golang-migrate/migrate/releases/download/v$MIGRATE_VER/migrate.linux-amd64.tar.gz
RUN curl -sSL $MIGRATE_URL | tar -C /tmp -xvzf -
RUN mv /tmp/migrate.linux-amd64 /usr/local/bin/migrate


################################################################################
# Source - jq
################################################################################
FROM $BASE_IMAGE AS source-jq
ENV JQ_VER=1.5
ENV JQ_URL=https://github.com/stedolan/jq/releases/download/jq-$JQ_VER/jq-linux64
RUN curl -sSL -o /usr/local/bin/jq $JQ_URL
RUN chmod +x /usr/local/bin/jq


################################################################################
# Source - yq
################################################################################
FROM $BASE_IMAGE AS source-yq
ENV YQ_VER=2.1.1
ENV YQ_URL=https://github.com/mikefarah/yq/releases/download/$YQ_VER/yq_linux_amd64
RUN curl -sSL -o /usr/local/bin/yq $YQ_URL
RUN chmod +x /usr/local/bin/yq


################################################################################
# Sources
################################################################################
FROM $BASE_IMAGE AS sources
COPY --from=source-gomplate /usr/local/bin/gomplate /usr/local/bin/gomplate
COPY --from=source-lego     /usr/local/bin/lego     /usr/local/bin/lego
COPY --from=source-migrate  /usr/local/bin/migrate  /usr/local/bin/migrate
COPY --from=source-jq       /usr/local/bin/jq       /usr/local/bin/jq
COPY --from=source-yq       /usr/local/bin/yq       /usr/local/bin/yq


################################################################################
# Runtime
################################################################################
FROM debian:stretch-slim

RUN export DEPS="curl make net-tools netcat" \
    && apt-get update && apt-get install -y $DEPS \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Sources
COPY --from=sources /usr/local/bin/* /usr/local/bin/
