# SimpleSAMLphp

This is a fully contained docker implementation of (simpleSAMLphp)[https://simplesamlphp.org]. It uses (eboraas/apache-php)[https://registry.hub.docker.com/u/eboraas/apache-php/] as the base image.

This is heavily influenced by the container created by John Frizelle <johnfriz@gmail.com>, but modified to include SSL and a few other bits.
https://github.com/johnfriz/docker/tree/master/simplesamlphp

# Installation Steps
As per the simpleSAMLphp [installation instructions](https://simplesamlphp.org/docs/stable/simplesamlphp-install), the following steps have been completed:

## Configuring Apache
The Dockerfile is used to over right Apache's default site file to add the appropriate alias for simpleSAMLphp. The docker file also adds a volume to allow us to mount the simpleSAMLphp code from outside the container - which makes configuring simpleSAMLphp significantly easier.

## simplSAMLphp configuration: config.php

As required, the admin password has been changed from the default of '123' to a new value 'password'. IF you wish to update this, change the value for 'auth.adminpassword' in ./simplesamlphp/config/config.php

The value for 'secretsalt' has also been updated from it's default of 'defaultsecretsalt' to the new value of 'newsecretsalt'

The values for technicalcontact_name and technicalcontact_email have aslo been updated to 'SimpleSAMLphp Technical Contact' and 'simplesamlphp@example.com' respectively.

# Building the image

To build the image from the Dockerfile, run the following command from the directory where the Dockerfile is located (or change the last parameter - . - to be the path to the Dockerfile)

    sudo docker build -t="johnfriz/simplesamlphp:v1" .

NOTE: Replace 'johnfriz' with your own docker user name if building the image yourself.

# Running the container

The source and configuration files for simpleSAMLphp must be mounted as a volume for the container using the -v option. If you want to expose the container on an alternative port, change the value for 8090 to your port of choice, or if you want to expose SSL map to port 443 in the container.

Docker Command:

    sudo docker run -p 8090:80 -p 8443:443 -v $(pwd)/simplesamlphp/:/var/simplesamlphp/ -d rgeyer/simplesamlphp

# Using simpleSAMLphp

Using the IP address of the host where the docker container is running, point your browser to the following URL:

http://<HOST-IP-ADDRESS>:<DOCKER-PORT>/simplesaml

e.g. if running on local host & using the value above for the docker port mapping (8090), the URL would be:

http://127.0.0.1:8090/simplesaml

Refer to the [simpleSAMLphp documentation](https://simplesamlphp.org/docs/stable/) for more information on additional configuration and usage
