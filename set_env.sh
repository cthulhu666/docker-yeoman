#!/bin/bash

set -eu

export DOCKER_HOST_IP=`netstat -nr | grep '^0\.0\.0\.0' | awk '{print $2}'`

"$@"
