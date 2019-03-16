ARG ALPINE_VER=3.9
################################################################################
# Source
################################################################################
FROM alpine:$ALPINE_VER AS source
ENV DNSFORWARDER_VER=6.1.15
ENV DNSFORWARDER_REPO=https://github.com/holmium/dnsforwarder.git
RUN export DEPS=" \
    gcc git make automake autoconf libc-dev curl-dev" \
    && apk add $DEPS
ENV DNSFORWARDER_DIR=/dnsforwarder
RUN mkdir $DNSFORWARDER_DIR
WORKDIR $DNSFORWARDER_DIR
RUN git init \
  && git remote add origin $DNSFORWARDER_REPO \
  && git fetch origin --depth 1 $DNSFORWARDER_VER \
  && git reset --hard FETCH_HEAD
RUN ./configure
RUN make
RUN mv ./dnsforwarder /usr/local/bin/


################################################################################
# Runtime
################################################################################
FROM alpine:$ALPINE_VER
RUN export DEPS=" \
    libcurl ca-certificates" \
    && apk add $DEPS
COPY --from=source /usr/local/bin/* /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/dnsforwarder"]
