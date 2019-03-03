ARG ALPINE_VER=3.9
################################################################################
# Source
################################################################################
FROM buildpack-deps:stretch AS source
RUN wget http://ftp.apnic.net/apnic/dbase/tools/ripe-dbase-client-v3.tar.gz
RUN mkdir /whois3-src
WORKDIR /whois3-src
RUN tar -xvzf /ripe-dbase-client-v3.tar.gz --strip-components=1
RUN ./configure && make
RUN cp whois3 /usr/local/bin


################################################################################
# Source
################################################################################
FROM frolvlad/alpine-glibc:alpine-${ALPINE_VER}
COPY --from=source /usr/local/bin /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/whois3"]
