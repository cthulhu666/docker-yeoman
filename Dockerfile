# Yeoman with some generators and prerequisites
FROM ubuntu:saucy
MAINTAINER Kevin Littlejohn "kevin@littlejohn.id.au"
# Fix the locale and install pre-requisites
# Install pre-requisites
RUN locale-gen en_US en_US.UTF-8; \
  DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales; \
  apt-get -y -q update; \
  apt-get -y -q upgrade; \
  DEBIAN_FRONTEND=noninteractive apt-get -y -q install python-software-properties software-properties-common python g++ make git ruby-compass
# Install node.js, then npm install yo and the generators
RUN add-apt-repository ppa:chris-lea/node.js -y; \
  apt-get -y -q update; \
  DEBIAN_FRONTEND=noninteractive apt-get -y -q install nodejs; \
  npm install yo -g; \
  npm install -g generator-webapp generator-angular
# Add a yeoman user because grunt doesn't like being root
RUN adduser --disabled-password --gecos "" yeoman
# Always run as the yeoman user
ENTRYPOINT ["/bin/su", "-", "yeoman"]
