FROM alpine AS source
ENV COMPOSE_VERSION=1.16.1
RUN apk add --no-cache curl
RUN curl -sSL -o /docker-compose \
    https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-Linux-x86_64
RUN chmod +x /docker-compose

FROM docker:17.10
COPY --from=source /docker-compose /usr/local/bin/docker-compose
