# dockerfiles
===========

Dockerfiles for images I've pushed to https://hub.docker.com/u/zealic


## Coinbox

* [Bitcoin](https://hub.docker.com/r/zealic/bitcoin)
* [Litecoin](https://hub.docker.com/r/zealic/litecoin)
* [Monero](https://hub.docker.com/r/zealic/monero)


## Devel

* [Docker](https://hub.docker.com/r/zealic/docker)
* [s3fs](https://hub.docker.com/r/zealic/s3fs)


## Network

* [chinadns](https://hub.docker.com/r/zealic/chinadns)
* [dnsforwarder](https://hub.docker.com/r/zealic/dnsforwarder)
* [frp](https://hub.docker.com/r/zealic/frp)
* [gost](https://hub.docker.com/r/zealic/gost)
* [openvpn](https://hub.docker.com/r/zealic/openvpn)
* [shadowsocks](https://hub.docker.com/r/zealic/shadowsocks)
* [shadowvpn](https://hub.docker.com/r/zealic/shadowvpn)
* [whois3](https://hub.docker.com/r/zealic/whois3)


## Toolkit

Toolkit include utility tools for your docker.


* [toolkit:latest](https://hub.docker.com/r/zealic/toolkit)
  * busybox
  * confd
  * gomplate
  * jq
  * lego
  * migrate
  * yq
  * gosu
  * tini
  * dumb-init
  * containerpilot
  * envoy
  * awless

* [toolkit:hashicorp](https://hub.docker.com/r/zealic/toolkit)
  * consul
  * packer
  * terraform
  * vault


Example

  ```dockerfile
  FROM alpine
  COPY --from=zealic/toolkit /usr/local/bin/busybox /usr/local/bin/busybox
  COPY myapp /
  ENTRYPOINT /usr/local/bin/busybox
  ...
  ```
