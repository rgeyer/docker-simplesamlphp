FROM eboraas/apache-php

MAINTAINER Ryan J. Geyer <me@ryangeyer.com>

# Install additional PHP modules requied by simplesamlphp
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install mcrypt php5-mcrypt php5-ldap php5-radius php5-memcache unzip build-essential apache2-threaded-dev wget

RUN wget http://curl.haxx.se/ca/cacert.pem -O /etc/ssl/certs/cacert.pem
RUN mkdir -p /tmp/rpaf
RUN wget https://github.com/gnif/mod_rpaf/archive/stable.zip -O /tmp/rpaf/stable.zip
RUN unzip /tmp/rpaf/stable.zip -d /tmp/rpaf/source
RUN cd /tmp/rpaf/source/mod_rpaf-stable && make && make install


RUN a2enmod socache_shmcb

# Override the apache default site & ssl site files to add an alias for simplesamlphp
ADD ./docker-source/default-site /etc/apache2/sites-available/default
ADD ./docker-source/default-ssl /etc/apache2/sites-available/default-ssl

# Create some mod_rpaf config goodness
ADD ./docker-source/mod_rpaf.conf /etc/apache2/mods-available/rpaf.conf
ADD ./docker-source/mod_rpaf.load /etc/apache2/mods-available/rpaf.load

RUN a2enmod rpaf

# Define a volume for the simplesamlphp application
VOLUME /var/simplesamlphp
