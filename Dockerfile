ARG SOURCE_IMAGE=alpine:3.9

################################################################################
# Source - busybox
################################################################################
FROM $SOURCE_IMAGE AS source-busybox
ENV BUSYBOX_VER=1.30.0
ENV BUSYBOX_URL=https://busybox.net/downloads/binaries/${BUSYBOX_VER}-i686/busybox
RUN wget -qO /usr/local/bin/busybox $BUSYBOX_URL
RUN chmod +x /usr/local/bin/busybox


################################################################################
# Source - curl
################################################################################
FROM $SOURCE_IMAGE AS source-curl
ENV CURL_VER=7.30.0
ENV CURL_URL=https://www.magicermine.com/demos/curl/curl/curl-${CURL_VER}.ermine.tar.bz2
RUN wget -qO- $CURL_URL | tar -C /tmp -xvjf -
RUN mv /tmp/curl-${CURL_VER}.ermine/curl.ermine /usr/local/bin/curl


################################################################################
# Source - confd
################################################################################
FROM $SOURCE_IMAGE AS source-confd
ENV CONFD_VER=0.16.0
ENV CONFD_URL=https://github.com/kelseyhightower/confd/releases/download/v$CONFD_VER/confd-$CONFD_VER-linux-amd64
RUN wget -qO /usr/local/bin/confd $CONFD_URL
RUN chmod +x /usr/local/bin/confd


################################################################################
# Source - consul
################################################################################
FROM $SOURCE_IMAGE AS source-consul
# consul
ENV CONSUL_VER=1.4.1
ENV CONSUL_URL=https://releases.hashicorp.com/consul/${CONSUL_VER}/consul_${CONSUL_VER}_linux_amd64.zip
RUN wget -qO consul.zip $CONSUL_URL && unzip -d /usr/local/bin consul.zip
# consul-template
ENV CONSULT_VER=0.19.5
ENV CONSULT_URL=https://releases.hashicorp.com/consul-template/$CONSULT_VER/consul-template_${CONSULT_VER}_linux_amd64.zip
RUN wget -qO consult.zip $CONSULT_URL && unzip -d /usr/local/bin consult.zip



################################################################################
# Source - gomplate
################################################################################
FROM $SOURCE_IMAGE AS source-gomplate
ENV GOMPLATE_VER=3.1.0
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
ENV LEGO_VER=2.1.0
ENV LEGO_URL=https://github.com/xenolf/lego/releases/download/v$LEGO_VER/lego_v${LEGO_VER}_linux_amd64.tar.gz
RUN wget -qO- $LEGO_URL | tar -C /tmp -xvzf -
RUN mv /tmp/lego /usr/local/bin/lego


################################################################################
# Source - migrate
################################################################################
FROM $SOURCE_IMAGE AS source-migrate
ENV MIGRATE_VER=4.2.3
ENV MIGRATE_URL=https://github.com/golang-migrate/migrate/releases/download/v$MIGRATE_VER/migrate.linux-amd64.tar.gz
RUN wget -qO- $MIGRATE_URL | tar -C /tmp -xvzf -
RUN mv /tmp/migrate.linux-amd64 /usr/local/bin/migrate


################################################################################
# Source - packer
################################################################################
FROM $SOURCE_IMAGE AS source-packer
ENV PACKER_VER=1.3.3
ENV PACKER_URL=https://releases.hashicorp.com/packer/$PACKER_VER/packer_${PACKER_VER}_linux_amd64.zip
RUN wget -qO packer.zip $PACKER_URL && unzip -d /usr/local/bin packer.zip


################################################################################
# Source - terraform
################################################################################
FROM $SOURCE_IMAGE AS source-terraform
ENV TERRAFORM_VER=0.11.11
ENV TERRAFORM_URL=https://releases.hashicorp.com/terraform/$TERRAFORM_VER/terraform_${TERRAFORM_VER}_linux_amd64.zip
RUN wget -qO terraform.zip $TERRAFORM_URL && unzip -d /usr/local/bin terraform.zip


################################################################################
# Source - vault
################################################################################
FROM $SOURCE_IMAGE AS source-vault
ENV VAULT_VER=1.0.2
ENV VAULT_URL=https://releases.hashicorp.com/vault/$VAULT_VER/vault_${VAULT_VER}_linux_amd64.zip
RUN wget -qO vault.zip $VAULT_URL && unzip -d /usr/local/bin vault.zip


################################################################################
# Source - yq
################################################################################
FROM $SOURCE_IMAGE AS source-yq
ENV YQ_VER=2.2.1
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
# Source - containerpilot
################################################################################
FROM $SOURCE_IMAGE AS source-containerpilot
ENV CONTAINERPILOT_VER=3.8.0
ENV CONTAINERPILOT_URL=https://github.com/joyent/containerpilot/releases/download/${CONTAINERPILOT_VER}/containerpilot-${CONTAINERPILOT_VER}.tar.gz
RUN wget -qO- $CONTAINERPILOT_URL | tar -C /tmp -xvzf -
RUN mv /tmp/containerpilot /usr/local/bin/containerpilot


################################################################################
# Source - envoy
################################################################################
FROM envoyproxy/envoy:v1.9.0 AS source-envoy
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
COPY --from=source-curl           /usr/local/bin/*  /usr/local/bin/
COPY --from=source-confd          /usr/local/bin/*  /usr/local/bin/
COPY --from=source-consul         /usr/local/bin/*  /usr/local/bin/
COPY --from=source-gomplate       /usr/local/bin/*  /usr/local/bin/
COPY --from=source-jq             /usr/local/bin/*  /usr/local/bin/
COPY --from=source-lego           /usr/local/bin/*  /usr/local/bin/
COPY --from=source-migrate        /usr/local/bin/*  /usr/local/bin/
COPY --from=source-packer         /usr/local/bin/*  /usr/local/bin/
COPY --from=source-terraform      /usr/local/bin/*  /usr/local/bin/
COPY --from=source-vault          /usr/local/bin/*  /usr/local/bin/
COPY --from=source-yq             /usr/local/bin/*  /usr/local/bin/
COPY --from=source-gosu           /usr/local/bin/*  /usr/local/bin/
COPY --from=source-tini           /usr/local/bin/*  /usr/local/bin/
COPY --from=source-dumb-init      /usr/local/bin/*  /usr/local/bin/
COPY --from=source-containerpilot /usr/local/bin/*  /usr/local/bin/
COPY --from=source-envoy          /usr/local/bin/*  /usr/local/bin/
COPY --from=source-awless         /usr/local/bin/*  /usr/local/bin/


################################################################################
# Runtime
################################################################################
FROM $SOURCE_IMAGE

RUN apk add --no-cache bash make curl git

# Sources
COPY --from=sources /usr/local/bin/* /usr/local/bin/

