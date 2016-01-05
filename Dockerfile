FROM scratch
MAINTAINER Zealic <zealic@gmail.com>

ADD busybox-x86_64 /busybox

# Fetch Openwrt
RUN ["/busybox", "wget", "https://downloads.openwrt.org/chaos_calmer/15.05/x86/64/openwrt-15.05-x86-64-rootfs.tar.gz", "-O", "openwrt.tar.gz" ]
RUN ["/busybox", "gunzip", "openwrt.tar.gz" ]
RUN ["/busybox", "tar", "-x", "--exclude=./etc/resolv.conf", "--exclude=./etc/hosts", "-f", "openwrt.tar" ]

RUN ["/busybox", "rm", "openwrt.tar"]

ADD network /etc/config/network

USER root
CMD /sbin/init
