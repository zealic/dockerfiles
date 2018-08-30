ARG BASE_IMAGE=alpine:edge

################################################################################
# Source - confd
################################################################################
FROM $BASE_IMAGE AS source-confd
ENV CONFD_VER=0.16.0
ENV CONFD_URL=https://github.com/kelseyhightower/confd/releases/download/v$CONFD_VER/confd-$CONFD_VER-linux-amd64
RUN wget -qO /usr/local/bin/confd $CONFD_URL
RUN chmod +x /usr/local/bin/confd


################################################################################
# Source - gomplate
################################################################################
FROM $BASE_IMAGE AS source-gomplate
ENV GOMPLATE_VER=2.7.0
ENV GOMPLATE_URL=https://github.com/hairyhenderson/gomplate/releases/download/v$GOMPLATE_VER/gomplate_linux-amd64
RUN wget -qO /usr/local/bin/gomplate $GOMPLATE_URL
RUN chmod +x /usr/local/bin/gomplate


################################################################################
# Source - jq
################################################################################
FROM $BASE_IMAGE AS source-jq
ENV JQ_VER=1.5
ENV JQ_URL=https://github.com/stedolan/jq/releases/download/jq-$JQ_VER/jq-linux64
RUN wget -qO /usr/local/bin/jq $JQ_URL
RUN chmod +x /usr/local/bin/jq


################################################################################
# Source - lego
################################################################################
FROM $BASE_IMAGE AS source-lego
ENV LEGO_VER=1.0.1
ENV LEGO_URL=https://github.com/xenolf/lego/releases/download/v$LEGO_VER/lego_v${LEGO_VER}_linux_amd64.tar.gz
RUN wget -qO- $LEGO_URL | tar -C /tmp -xvzf -
RUN mv /tmp/lego /usr/local/bin/lego


################################################################################
# Source - migrate
################################################################################
FROM $BASE_IMAGE AS source-migrate
ENV MIGRATE_VER=3.4.0
ENV MIGRATE_URL=https://github.com/golang-migrate/migrate/releases/download/v$MIGRATE_VER/migrate.linux-amd64.tar.gz
RUN wget -qO- $MIGRATE_URL | tar -C /tmp -xvzf -
RUN mv /tmp/migrate.linux-amd64 /usr/local/bin/migrate


################################################################################
# Source - packer
################################################################################
FROM $BASE_IMAGE AS source-packer
ENV PACKER_VER=1.2.5
ENV PACKER_URL=https://releases.hashicorp.com/packer/$PACKER_VER/packer_${PACKER_VER}_linux_amd64.zip
RUN wget -qO packer.zip $PACKER_URL && unzip -d /usr/local/bin packer.zip


################################################################################
# Source - terraform
################################################################################
FROM $BASE_IMAGE AS source-terraform
ENV TERRAFORM_VER=0.11.8
ENV TERRAFORM_URL=https://releases.hashicorp.com/terraform/$TERRAFORM_VER/terraform_${TERRAFORM_VER}_linux_amd64.zip
RUN wget -qO terraform.zip $TERRAFORM_URL && unzip -d /usr/local/bin terraform.zip


################################################################################
# Source - vault
################################################################################
FROM $BASE_IMAGE AS source-vault
ENV VAULT_VER=0.11.0
ENV VAULT_URL=https://releases.hashicorp.com/vault/$VAULT_VER/vault_${VAULT_VER}_linux_amd64.zip
RUN wget -qO vault.zip $VAULT_URL && unzip -d /usr/local/bin vault.zip


################################################################################
# Source - yq
################################################################################
FROM $BASE_IMAGE AS source-yq
ENV YQ_VER=2.1.1
ENV YQ_URL=https://github.com/mikefarah/yq/releases/download/$YQ_VER/yq_linux_amd64
RUN wget -qO /usr/local/bin/yq $YQ_URL
RUN chmod +x /usr/local/bin/yq


################################################################################
# Sources
################################################################################
FROM $BASE_IMAGE AS sources
COPY --from=source-confd      /usr/local/bin/confd     /usr/local/bin/confd
COPY --from=source-gomplate   /usr/local/bin/gomplate  /usr/local/bin/gomplate
COPY --from=source-jq         /usr/local/bin/jq        /usr/local/bin/jq
COPY --from=source-lego       /usr/local/bin/lego      /usr/local/bin/lego
COPY --from=source-migrate    /usr/local/bin/migrate   /usr/local/bin/migrate
COPY --from=source-packer     /usr/local/bin/packer    /usr/local/bin/packer
COPY --from=source-terraform  /usr/local/bin/terraform /usr/local/bin/terraform
COPY --from=source-vault      /usr/local/bin/vault     /usr/local/bin/vault
COPY --from=source-yq         /usr/local/bin/yq        /usr/local/bin/yq


################################################################################
# Runtime
################################################################################
FROM debian:stretch-slim

RUN export DEPS="procps curl make net-tools netcat" \
    && apt-get update && apt-get install -yqq $DEPS \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Sources
COPY --from=sources /usr/local/bin/* /usr/local/bin/
