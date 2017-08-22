PPTP Daemon Docker Image
====================

This repository contains `Dockerfile` definitions for [PPTP][pptp] Docker images.


## Supported tags

* [`latest` _(Dockerfile)_](Dockerfile)

Getting started for this docker container at the [Docker Hub][registry].


## Usage
* Enable `ip_nat_pptp` module
```shell
modprobe ip_nat_pptp
echo ip_nat_pptp > /etc/modules-load.d/ip_nat_pptp.conf
```

* Run container
```shell
curl -L https://raw.github.com/zealic/dockerfiles/master/pptpd/run-container.sh | sh
```


[pptp]: http://en.wikipedia.org/wiki/Point-to-Point_Tunneling_Protocol
[registry]: https://registry.hub.docker.com/u/zealic/pptpd
