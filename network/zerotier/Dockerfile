ARG ALPINE_VER=3.13
################################################################################
# Source
################################################################################
FROM alpine:$ALPINE_VER AS source
RUN export DEPS=" \
    gcc g++ git make libc-dev linux-headers nodejs-npm" \
    && apk add $DEPS
ENV ZEROTIER_VER=1.6.4
ENV ZEROTIER_REPO=https://github.com/zerotier/ZeroTierOne.git
ENV ZEROTIER_DIR=/zerotier
RUN mkdir $ZEROTIER_DIR
WORKDIR $ZEROTIER_DIR
RUN git init \
  && git remote add origin $ZEROTIER_REPO \
  && git fetch origin --depth 1 $ZEROTIER_VER \
  && git reset --hard FETCH_HEAD
RUN make
RUN mv ./zerotier-one /usr/local/bin/


################################################################################
# Runtime
################################################################################
FROM alpine:$ALPINE_VER
RUN export DEPS=" \
    libstdc++ ca-certificates" \
    && apk add $DEPS
ADD ./entrypoint.sh /
COPY --from=source /usr/local/bin/* /usr/local/bin/
RUN ln -sf /usr/local/bin/zerotier-one /usr/local/bin/zerotier-cli \
  && ln -sf /usr/local/bin/zerotier-one /usr/local/bin/zerotier-idtool

EXPOSE 9993/udp
ENTRYPOINT ["/entrypoint.sh"]
