FROM eboraas/apache-php

MAINTAINER Ryan J. Geyer <me@ryangeyer.com>

# Install additional PHP modules requied by simplesamlphp
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install mcrypt php5-mcrypt php5-ldap php5-radius php5-memcache

RUN a2enmod socache_shmcb

# Override the apache default site & ssl site files to add an alias for simplesamlphp
ADD ./docker-source/default-site /etc/apache2/sites-available/default
ADD ./docker-source/default-ssl /etc/apache2/sites-available/default-ssl

# Define a volume for the simplesamlphp application
VOLUME /var/simplesamlphp
