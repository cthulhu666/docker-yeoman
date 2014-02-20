# Yeoman with some generators and prerequisites
FROM ubuntu:saucy
MAINTAINER Kevin Littlejohn "kevin@littlejohn.id.au"
# Fix the locale
# Install node.js and requisites
# Add a yeoman user and install yeoman and requisites
RUN locale-gen en_US en_US.UTF-8 && dpkg-reconfigure locales; \
  apt-get -y -q update; \
  apt-get -y -q upgrade; \
  apt-get -y -q install python-software-properties software-properties-common python g++ make git ruby-compass; \
  add-apt-repository ppa:chris-lea/node.js -y; \
  apt-get -y -q update; \
  apt-get -y -q install nodejs; \
  npm install yo -g; \
  npm install -g generator-webapp generator-angular; \
  adduser --disabled-password --gecos "" yeoman
CMD ["/bin/su", "-", "yeoman"]