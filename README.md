This is intended to be used in conjunction with docker-gen, letsencrypt and a
https proxy.

```yaml
  ttrss:
    image: junkdna/ttrss:latest
    container_name: ttrss
    networks:
      - nginx-proxy
    links:
      - pgsql:db
    volumes:
      - /volumes/ttrss/config.php:/srv/www/config.php
      - /dev/log:/dev/log
      - /var/run/systemd/journal/socket:/var/run/systemd/journal/socket
      - /etc/passwd:/etc/passwd:ro
      - /etc/group:/etc/group:ro
    environment:
      - VIRTUAL_HOST=ttrss.example.com
      - VIRTUAL_NETWORK=nginx-proxy
      - LETSENCRYPT_HOST=ttrss.example.com
      - LETSENCRYPT_EMAIL=root@example.com
```
