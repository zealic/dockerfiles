# Don't Starve Server Docker Image

This repository contains `Dockerfile` definitions for [Don't Starve Server][dst] Docker images.

## Supported tags

* [`latest` _(Dockerfile)_](Dockerfile)

Getting started for this docker container at the [Docker Hub][registry].



## Server Token
Use `SERVER_TOKEN` environment variable to authenticate server.

```shell
docker run -d -e SERVER_TOKEN=<YOUR_SERVER_TOKEN> zealic/dst_server
```


## Volume Directory
Data volume directory is `/DST`



[dst]: http://dont-starve-game.wikia.com/wiki/Don%27t_Starve_Wiki
[registry]: https://registry.hub.docker.com/u/zealic/dst_server
