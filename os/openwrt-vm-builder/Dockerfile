FROM debian:jessie
MAINTAINER zealic <zealic@gmail.com>

RUN apt-get update && apt-get install -y qemu curl ruby \
  && gem install thor \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# FROM : https://aur.archlinux.org/packages/vmware-ovftool/
RUN curl -#SL https://dl.dropboxusercontent.com/u/99802211/external_sources/VMware%20OVFTool/VMware-ovftool-4.1.0-2459827-lin.x86_64.bundle > /tmp/ovftool.bundle \
  && chmod +x /tmp/ovftool.bundle && echo -n "\n" | /tmp/ovftool.bundle --eulas-agreed \
  && rm -rf /tmp/*

ADD Thorfile /

ENTRYPOINT ["/usr/local/bin/thor"]
