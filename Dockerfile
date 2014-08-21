# Yeoman with some generators and prerequisites
FROM ubuntu:trusty
MAINTAINER Jakub Głuszecki <jakub.gluszecki@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

# Fix the locale and install pre-requisites
RUN locale-gen en_US en_US.UTF-8 && \
  dpkg-reconfigure locales && \
  apt-get -yq update && \
  apt-get -yq install python-software-properties software-properties-common python g++ make git ruby-compass libfreetype6

# Install node.js, then npm install yo and the generators
RUN add-apt-repository ppa:chris-lea/node.js -y && \
  apt-get -yq update && \
  DEBIAN_FRONTEND=noninteractive apt-get -yq install nodejs && \
  npm install yo -g && \
  npm install -g generator-webapp generator-angular

# Add a yeoman user because grunt doesn't like being root
RUN adduser --disabled-password --gecos "" yeoman && \
  echo "yeoman ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Expose the port
EXPOSE 9000

# set HOME so 'npm install' and 'bower install' don't write to /
ENV HOME /home/yeoman

RUN mkdir /src
RUN chown yeoman:yeoman /src
WORKDIR /src

# Always run as the yeoman user
USER yeoman
