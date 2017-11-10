FROM jenkins/jenkins:2.89

USER root
RUN  curl -fsSL get.docker.com -o get-docker.sh && \
     sh get-docker.sh && \
     usermod -aG docker jenkins

USER jenkins
RUN /usr/local/bin/install-plugins.sh git workflow-aggregator docker-workflow pipeline-utility-steps

ENV JENKINS_USER admin
ENV JENKINS_PASS admin

# Skip initial setup
ENV JENKINS_OPTS -Djenkins.install.runSetupWizard=false

COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY default-user.groovy /usr/share/jenkins/ref/init.groovy.d/

COPY fuse_build_job_config.xml /usr/share/jenkins/ref/jobs/fuse-test/config.xml
