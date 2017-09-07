#!/bin/bash
DOCKER_GID=`getent group docker | awk '{split($0, a, ":"); print a[3]}'`
echo $DOCKER_GID
docker rm -f jenkins
docker run --name jenkins \
    -v ~/jenkins_home:/var/jenkins_home \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --group-add $DOCKER_GID \
    --restart always \
    -p 9090:8080 \
-d atos/jenkins:1.0
