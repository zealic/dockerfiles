ARG ALPINE_VER=3.9
ARG SOURCE_IMAGE=alpine:${ALPINE_VER}

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
# Sources
################################################################################
FROM $SOURCE_IMAGE AS sources
COPY --from=source-consul         /usr/local/bin/*  /usr/local/bin/
COPY --from=source-packer         /usr/local/bin/*  /usr/local/bin/
COPY --from=source-terraform      /usr/local/bin/*  /usr/local/bin/
COPY --from=source-vault          /usr/local/bin/*  /usr/local/bin/


################################################################################
# Runtime
################################################################################
FROM $SOURCE_IMAGE

RUN apk add --no-cache bash make curl git

# Sources
COPY --from=sources /usr/local/bin/* /usr/local/bin/
