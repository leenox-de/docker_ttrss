FROM ubuntu:bionic
MAINTAINER Tillmann Heidsieck <theidsieck@leenox.de>
EXPOSE 80

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
	cron \
	git-core \
	php-cli \
	php-curl \
	php-dom \
	php-fpm \
	php-gd \
	php-json \
	php-mbstring \
	php-mcrypt \
	php-mysql \
	php-pgsql \
	php-xmlrpc \
	nginx-extras \
	ssmtp \
	supervisor

RUN ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
	dpkg-reconfigure --frontend noninteractive tzdata

RUN useradd --user-group -d /srv -r -s /bin/bash ttrss

COPY supervisord.conf /etc/
COPY crontab /etc/
COPY nginx.conf /etc/nginx/
COPY run.sh /usr/bin/
COPY www.conf /etc/php/7.2/fpm/pool.d/

RUN mkdir /run/php && chown ttrss /srv /run/php

USER ttrss
RUN cd /srv && git clone https://tt-rss.org/gitlab/fox/tt-rss.git www

USER root

ENTRYPOINT ["/usr/bin/run.sh"]
