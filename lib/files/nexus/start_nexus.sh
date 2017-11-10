#!/bin/bash
docker rm -f nexus3
docker run --name nexus3 \
    -v ~/nexus-data:/nexus-data \
    --restart always \
    -p 8081:8081 \
    -p 80:2375 \
    --network citools \
    -d \
    sonatype/nexus3:3.5.0
