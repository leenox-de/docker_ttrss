#!/bin/bash

export PATH=/usr/bin:$PATH

if [[ -z "$RUN_AS" ]]; then
	RUN_AS=ttrss
fi

if [[ -z "$RUN_AS_GROUP" ]]; then
	RUN_AS_GROUP=$RUN_AS
fi

echo -e "RUN_AS='$RUN_AS'\nRUN_AS_GROUP='$RUN_AS_GROUP'" > /run_as

sed -e "s/www-data/$RUN_AS/g" -i /etc/php/7.2/fpm/pool.d/www.conf
sed -e "s/user \+nginx;/user $RUN_AS;/" -i /etc/nginx/nginx.conf
chown -R $RUN_AS.$RUN_AS /srv

exec /usr/bin/supervisord -c /etc/supervisord.conf
