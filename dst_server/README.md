# Don't Starve Server Docker Image

This repository contains `Dockerfile` definitions for [Don't Starve Server][dst] Docker images.

## Supported tags

* [`latest` _(Dockerfile)_](https://github.com/zealic/dockerfiles/blob/master/dst_server/Dockerfile)

Getting started for this docker container at the [Docker Hub][registry].



## Server Token
Use `SERVER_TOKEN` environment variable to authenticate server.

```shell
docker run -d -e SERVER_TOKEN=<YOUR_SERVER_TOKEN> zealic/dst_server
```


## Volume Directory
Data volume directory is `/DST`

Host directory owners must be 10999:10999

## Usage
```shell
mkdir $HOME/dst_data
chown 10999:10999 $HOME/dst_data
docker run -d -e SERVER_TOKEN=... -v $HOME/dst_data:/DST zealic/dst_server
```



[dst]: http://dont-starve-game.wikia.com/wiki/Don%27t_Starve_Wiki
[registry]: https://registry.hub.docker.com/u/zealic/dst_server
