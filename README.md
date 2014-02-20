yeoman
======

Docker file for base yeoman install

docker run -i -t silarsis/yeoman

This will run the container and log you in as the "yeoman" user,
ready to "yo". If you want to run something else (eg. "grunt serve"),
then you can "docker run silarsis/yeoman -c grunt serve".