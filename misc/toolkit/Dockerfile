ARG ALPINE_VER=3.11
ARG SOURCE_IMAGE=alpine:${ALPINE_VER}

################################################################################
# Source - busybox
################################################################################
FROM $SOURCE_IMAGE AS source-busybox
ENV BUSYBOX_VER=1.30.0
ENV BUSYBOX_URL=https://busybox.net/downloads/binaries/${BUSYBOX_VER}-i686/busybox
RUN wget -qO /usr/local/bin/busybox $BUSYBOX_URL
RUN chmod +x /usr/local/bin/busybox


################################################################################
# Source - confd
################################################################################
FROM $SOURCE_IMAGE AS source-confd
ENV CONFD_VER=0.16.0
ENV CONFD_URL=https://github.com/kelseyhightower/confd/releases/download/v$CONFD_VER/confd-$CONFD_VER-linux-amd64
RUN wget -qO /usr/local/bin/confd $CONFD_URL
RUN chmod +x /usr/local/bin/confd


################################################################################
# Source - gomplate
################################################################################
FROM $SOURCE_IMAGE AS source-gomplate
ENV GOMPLATE_VER=3.6.0
ENV GOMPLATE_URL=https://github.com/hairyhenderson/gomplate/releases/download/v$GOMPLATE_VER/gomplate_linux-amd64
RUN wget -qO /usr/local/bin/gomplate $GOMPLATE_URL
RUN chmod +x /usr/local/bin/gomplate


################################################################################
# Source - jq
################################################################################
FROM $SOURCE_IMAGE AS source-jq
ENV JQ_VER=1.6
ENV JQ_URL=https://github.com/stedolan/jq/releases/download/jq-$JQ_VER/jq-linux64
RUN wget -qO /usr/local/bin/jq $JQ_URL
RUN chmod +x /usr/local/bin/jq


################################################################################
# Source - lego
################################################################################
FROM $SOURCE_IMAGE AS source-lego
ENV LEGO_VER=3.4.0
ENV LEGO_URL=https://github.com/xenolf/lego/releases/download/v$LEGO_VER/lego_v${LEGO_VER}_linux_amd64.tar.gz
RUN wget -qO- $LEGO_URL | tar -C /tmp -xvzf -
RUN mv /tmp/lego /usr/local/bin/lego


################################################################################
# Source - migrate
################################################################################
FROM $SOURCE_IMAGE AS source-migrate
ENV MIGRATE_VER=4.9.1
ENV MIGRATE_URL=https://github.com/golang-migrate/migrate/releases/download/v$MIGRATE_VER/migrate.linux-amd64.tar.gz
RUN wget -qO- $MIGRATE_URL | tar -C /tmp -xvzf -
RUN mv /tmp/migrate.linux-amd64 /usr/local/bin/migrate


################################################################################
# Source - yq
################################################################################
FROM $SOURCE_IMAGE AS source-yq
ENV YQ_VER=3.2.1
ENV YQ_URL=https://github.com/mikefarah/yq/releases/download/$YQ_VER/yq_linux_amd64
RUN wget -qO /usr/local/bin/yq $YQ_URL
RUN chmod +x /usr/local/bin/yq


################################################################################
# Source - gosu
################################################################################
FROM $SOURCE_IMAGE AS source-gosu
ENV GOSU_VER 1.11
ENV GOSU_URL=https://github.com/tianon/gosu/releases/download/${GOSU_VER}/gosu-amd64
RUN wget -qO /usr/local/bin/gosu $GOSU_URL
RUN chmod +x /usr/local/bin/gosu


################################################################################
# Source - tini
################################################################################
FROM $SOURCE_IMAGE AS source-tini
ENV TINI_VER v0.18.0
ENV TINI_URL=https://github.com/krallin/tini/releases/download/${TINI_VER}/tini
RUN wget -qO /usr/local/bin/tini $TINI_URL
RUN chmod +x /usr/local/bin/tini


################################################################################
# Source - dumb-init
################################################################################
FROM $SOURCE_IMAGE AS source-dumb-init
ENV DUMB_INIT_VER 1.2.2
ENV DUMB_INIT_URL=https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VER}/dumb-init_${DUMB_INIT_VER}_amd64
RUN wget -qO /usr/local/bin/dumb-init $DUMB_INIT_URL
RUN chmod +x /usr/local/bin/dumb-init


################################################################################
# Source - envoy
################################################################################
FROM envoyproxy/envoy-alpine:v1.13.1 AS source-envoy
# Envoy already in /usr/local/bin


################################################################################
# Source - awless
################################################################################
FROM $SOURCE_IMAGE AS source-awless
ENV AWLESS_VER=0.1.11
ENV AWLESS_URL=https://github.com/wallix/awless/releases/download/v${AWLESS_VER}/awless-linux-amd64.tar.gz
RUN wget -qO- $AWLESS_URL | tar -C /tmp -xvzf -
RUN mv /tmp/awless /usr/local/bin/awless


################################################################################
# Sources
################################################################################
FROM $SOURCE_IMAGE AS sources
COPY --from=source-busybox        /usr/local/bin/*  /usr/local/bin/
COPY --from=source-confd          /usr/local/bin/*  /usr/local/bin/
COPY --from=source-gomplate       /usr/local/bin/*  /usr/local/bin/
COPY --from=source-jq             /usr/local/bin/*  /usr/local/bin/
COPY --from=source-lego           /usr/local/bin/*  /usr/local/bin/
COPY --from=source-migrate        /usr/local/bin/*  /usr/local/bin/
COPY --from=source-yq             /usr/local/bin/*  /usr/local/bin/
COPY --from=source-gosu           /usr/local/bin/*  /usr/local/bin/
COPY --from=source-tini           /usr/local/bin/*  /usr/local/bin/
COPY --from=source-dumb-init      /usr/local/bin/*  /usr/local/bin/
COPY --from=source-envoy          /usr/local/bin/*  /usr/local/bin/
COPY --from=source-awless         /usr/local/bin/*  /usr/local/bin/


################################################################################
# Runtime
################################################################################
FROM $SOURCE_IMAGE

RUN apk add --no-cache bash make curl git

# Sources
COPY --from=sources /usr/local/bin/* /usr/local/bin/
