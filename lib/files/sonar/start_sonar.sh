#!/bin/bash
docker rm -f sonar
docker run --name sonar \
    --restart always \
    -p 9000:9000\
    --network citools \
    -d sonarqube:6.5
