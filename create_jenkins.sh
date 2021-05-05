#!/bin/bash

# This script will create a Jenkins container image named 'local_jenkins' from
# the official Jenkins LTS image.
#
# After running this script once, you can start/stop Jenkins using:
#   docker <start/stop> local_jenkins
#
# For the server, I chose to use port 8443, ie: localhost:8443
#
# TODO: First need to make the local volume (localVol) where Jenkins can persist data.
#   sudo mkdir -p /opt/docker/jenkins/jenkins_home
#   sudo chmod -R 777 /opt/docker/jenkins/jenkins_home
# Docker will do it but with root permissions, which is not what you want.
# The local volume can be found after the command line switch -v localVol:containerVol
docker run --name local_jenkins -d -p 8443:8080 -p 50000:50000 -v /opt/docker/jenkins/jenkins_home:/var/jenkins_home  jenkins/jenkins:lts
