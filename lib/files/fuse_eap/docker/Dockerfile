FROM openjdk:8-jdk-alpine
#
MAINTAINER Tim Robinson tim.robinson@atos.net
#
# This Dockerfile requires a web server to host
# the Red Hat JBoss software packages it is expected
# the web server is running on the Docker build host
# on port 8080
#
ENV EAP_ZIP=jboss-eap-6.4.0.zip
ENV FUSE_JAR=fuse-eap-installer-6.3.0.redhat-187.jar

USER root
RUN \
  addgroup -g 1001 jboss &&\
  adduser -u 1001 -D -h /home/jboss -G jboss -g "JBoss User" -s /bin/sh jboss &&\ 
  mkdir /opt

#
# Deploy JBoss EAP 6.4
#
RUN apk --no-cache add curl 
RUN DOCKER_HOST=`/sbin/ip route|awk '/default/ { print $3 }'` &&\
    cd /tmp && curl -O "http://$DOCKER_HOST:8080/$EAP_ZIP" &&\
    unzip /tmp/$EAP_ZIP -d /opt &&\
    rm -f /tmp/*.zip &&\
    mv /opt/jboss-eap-6.4 /opt/eap
#
# Apply JBoss Fuse 6.3.0 for EAP patch
#
RUN DOCKER_HOST=`/sbin/ip route|awk '/default/ { print $3 }'` &&\
    cd /tmp && curl -O "http://$DOCKER_HOST:8080/$FUSE_JAR" &&\
    cd /opt/eap &&\
    java -jar /tmp/$FUSE_JAR &&\
    rm -f /tmp/$FUSE_JAR /tmp/*.zip &&\
    chown -R jboss:jboss /opt/eap

USER jboss

CMD /opt/eap/bin/standalone.sh -c standalone.xml -bmanagement 0.0.0.0 -b 0.0.0.0