# Run a jenkins instance in a Docker container
# Run: docker build -t local_jenkins .

FROM jenkins/jenkins:lts

USER root

RUN apt-get -y update && apt-get -y upgrade

USER jenkins

