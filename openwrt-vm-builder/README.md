OpenWRT Image Builder Docker Image
====================

This repository contains `Dockerfile` definitions for [OpenWRT][openwrt] Docker images.

## Usage
`sudo docker run -it --rm=true -v $PWD/target:/build zealic/openwrt-image-builder build:ova --output /build/OpenWRT.ova`

## Supported format
* OVA

## Supported tags

* [`latest` _(Dockerfile)_](https://github.com/zealic/docker-library-openwrt-image-builder/blob/master/Dockerfile)

Getting started for this docker container at the [Docker Hub][registry].

[openwrt]: en.wikipedia.org/wiki/OpenWRT
[registry]: https://registry.hub.docker.com/u/zealic/openwrt-image-builder
