FROM ruby:2.1.3

ENV GOLLUM_VERSION 3.0.0

# FUCK the Garbage Firewall
RUN printf '#!/bin/bash\
deb http://mirrors.163.com/debian jessie main non-free contrib\
deb http://mirrors.163.com/debian jessie-updates main contrib non-free\
deb http://mirrors.163.com/debian-security jessie/updates main contrib non-free'\
>> /etc/apt/sources.list && apt-get update && apt-get install -y libicu-dev

RUN curl -SLO "https://github.com/gollum/gollum/archive/v$GOLLUM_VERSION.tar.gz" \
	&& mkdir -p /usr/local/gollum \
	&& tar -xvf v$GOLLUM_VERSION.tar.gz -C /usr/local/gollum --strip-components=1 \
	&& rm "v$GOLLUM_VERSION.tar.gz" \
	&& sed -i 's/rubygems.org/ruby.taobao.org/g' /usr/local/gollum/Gemfile \
	&& cd /usr/local/gollum \
	&& bundle install

ENV PATH /usr/local/gollum/bin:$PATH
WORKDIR /var/lib/gollum

EXPOSE 4567
ENTRYPOINT ["gollum"]
