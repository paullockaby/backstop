FROM debian:bookworm-slim@sha256:24c92a69df28b21676d721fe18c0bf64138bfc69b486746ad935b49cc31b0b91 AS base

# github metadata
LABEL org.opencontainers.image.source=https://github.com/paullockaby/backstop

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update && apt-get -y upgrade \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# first install apache
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update && apt-get -y upgrade \
 && apt-get install -y --no-install-recommends \
      apache2 apache2-utils prometheus-apache-exporter \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# then set up the configuration
RUN a2dismod autoindex access_compat -f \
 && a2disconf security serve-cgi-bin other-vhosts-access-log -f \
 && a2enmod remoteip headers rewrite deflate status \
 && sed -i '/^ErrorLog/d' /etc/apache2/apache2.conf \
 && rm -rf /var/www/html

# copy all configurations first. anything in /var/www/html will be put into
# the container and will be public. but if it has the same name as something
# that the static site generator *also* created then it will be overwritten.
COPY /conf /

EXPOSE 80/tcp
ENTRYPOINT ["/entrypoint"]
