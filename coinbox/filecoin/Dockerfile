ARG ALPINE_VER=3.9

################################################################################
# Source
################################################################################
FROM alpine:${ALPINE_VER} AS source
ENV FILECOIN_VER=0.0.1
ENV FILECOIN_URL=https://github.com/filecoin-project/go-filecoin/releases/download/${FILECOIN_VER}/filecoin-Linux.tar.gz
RUN wget -qO- $FILECOIN_URL | tar -C /opt -xvzf -


################################################################################
# Runtime
################################################################################
FROM frolvlad/alpine-glibc:alpine-${ALPINE_VER}
COPY --from=source /opt/filecoin /opt/filecoin/
RUN ln -s /opt/filecoin/go-filecoin /usr/local/bin/go-filecoin
ADD entrypoint.sh /

VOLUME ["/var/lib/filecoin"]
EXPOSE 6000
ENTRYPOINT ["/entrypoint.sh"]
CMD ["daemon"]
