#!/bin/bash

export PATH=/usr/bin:$PATH

chown -R ttrss.ttrss /srv

exec /usr/bin/supervisord -c /etc/supervisord.conf
