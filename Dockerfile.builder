FROM alpine:3.9
# habitus 1.0.4 --os flag not work, so need bash
RUN apk add bash

# Base tool
ENV PUP_VER=0.4.0
ENV PUP_URL=https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_amd64.zip
RUN wget -qO pup.zip $PUP_URL && unzip -d /usr/bin pup.zip

# Resolve all versions
