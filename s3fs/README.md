s3fs Docker Image
====================

This repository contains `Dockerfile` definitions for [s3fs][s3fs] Docker images.

## Supported tags

* [`latest` _(Dockerfile)_](Dockerfile)

## Usage
* mount to /data
```shell
docker run -e AWS_ACCESS_KEY_ID=<AWS_ACCESS_KEY> -e AWS_SECRET_KEY_ID=<AWS_SECRET_KEY> \
    -d --cap-add SYS_ADMIN --device=/dev/fuse \
    zealic/s3fs \
    -f -d -o <BUCKET_NAME> <MOUNT_POINT>
```

## Tips
s3fs mounted directory can not export as data volume.

## Links
Getting started for this docker container at the [Docker Hub][registry].

[s3fs]: https://github.com/s3fs-fuse/s3fs-fuse
[registry]: https://registry.hub.docker.com/u/zealic/s3fs
