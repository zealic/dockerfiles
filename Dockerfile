################################################################################
# Source - Lego
################################################################################
FROM xenolf/lego AS source-lego


################################################################################
# Source - Migrate
################################################################################
FROM golang:1.9-alpine AS source-migrate
RUN apk add --no-cache gcc g++ git
RUN go get github.com/mattes/migrate \
    && go get github.com/mattes/migrate/database/postgres
RUN export VERSION=`git describe --tags 2>/dev/null | cut -c 2-` \
    && cd /go/src/github.com/mattes/migrate/cli \
    && go build -a -o /usr/local/bin/migrate -ldflags="${VERSION}" -tags 'postgres file' .


################################################################################
# Source - yq
################################################################################
FROM golang:1.9-alpine AS source-yq
RUN apk add --no-cache git
RUN go get github.com/mikefarah/yq


################################################################################
# Runtime
################################################################################
FROM alpine:3.7

RUN apk add --no-cache make ca-certificates bash jq gomplate

# Sources
COPY --from=source-lego    /usr/bin/lego          /usr/local/bin/lego
COPY --from=source-migrate /usr/local/bin/migrate /usr/local/bin/migrate
COPY --from=source-yq      /go/bin/yq             /usr/local/bin/yq
