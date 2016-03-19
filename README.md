## yeoman


**Docker** image with base yeoman install, with a few generators pre-installed.

[![Build Status](https://travis-ci.org/cthulhu666/docker-yeoman.svg?branch=master)](https://travis-ci.org/cthulhu666/docker-yeoman)

### Usage

#### Scaffold web application using yeoman

With Grunt:

```
docker run -it --rm -v $(pwd):/src cthulhu666/yeoman:grunt yo webapp [your-app-name]
```

__From version 1.7.0 Grunt image is no longer maintained__

With Gulp:

```
docker run -it --rm -v $(pwd):/src cthulhu666/yeoman:gulp yo gulp-webapp [your-app-name]
```

[See Asciicast](https://asciinema.org/a/13240)

#### As a base image

Let's say we want a to run an angular app.

```
docker run -it --rm -v $(pwd):/src cthulhu666/yeoman:grunt yo angular [your-app-name]
```

Create Dockerfile inside your source directory:


    FROM cthulhu666/yeoman

    # Install compass
    RUN sudo apt-get -yq update && \
        sudo apt-get -yq install ruby-compass

Find this snippet in your Gruntfile:

    connect: {
      options: {
        port: 9000,
        // Change this to '0.0.0.0' to access the server from outside.
        hostname: 'localhost',
        livereload: 35729
      },

... and change 'localhost' to '0.0.0.0'


Build your image:
```
docker build -t [your-image-tag] .
```

Run it:

```
docker run -it -p 9000:9000 -p 35729:35729 --rm -v $(pwd):/src [your-image-tag] grunt serve
```

Remember to call npm and bower via docker:

```
docker run -it --rm -v $(pwd):/src [your-image-tag] npm install && bower install
```
