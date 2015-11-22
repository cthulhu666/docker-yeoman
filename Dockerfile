# Yeoman with some generators and prerequisites
FROM debian:jessie

MAINTAINER Jakub Głuszecki <jakub.gluszecki@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install node.js, then npm install yo and the generators
RUN apt-get -yq update && \
    apt-get -yq install git curl net-tools sudo bzip2 libpng-dev locales-all

RUN curl -sL https://deb.nodesource.com/setup_5.x | bash - && \
    apt-get -yq install nodejs

RUN npm install -g yo@1.5.0 bower@1.6.4 grunt-cli@0.1.13 gulp@3.9.0 && \
    npm install -g generator-webapp@1.1.0 generator-angular@0.14.0 generator-gulp-angular@1.0.0

# Add a yeoman user because grunt doesn't like being root
RUN adduser --disabled-password --gecos "" yeoman && \
  echo "yeoman ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Expose the port
EXPOSE 9000

# set HOME so 'npm install' and 'bower install' don't write to /
ENV HOME /home/yeoman

ENV LANG en_US.UTF-8

RUN mkdir /src && chown yeoman:yeoman /src
WORKDIR /src

ADD set_env.sh /usr/local/sbin/
RUN chmod +x /usr/local/sbin/set_env.sh
ENTRYPOINT ["set_env.sh"]

# Always run as the yeoman user
USER yeoman

CMD /bin/bash

