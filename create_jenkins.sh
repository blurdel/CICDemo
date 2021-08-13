#!/bin/bash

# This script will create a Jenkins container image named 'jenkins' from
# the official Jenkins LTS image.
#
# After running this script once, you can start/stop Jenkins using:
#   docker <start/stop> jenkins
#
# TODO: First need to make the local volume (localVol) where Jenkins can persist data.
#   sudo mkdir -p /opt/docker/jenkins/jenkins_home
#   sudo chmod -R 777 /opt/docker/jenkins
# Docker will do it but with root permissions, which is not what you want.
# The local volume can be found after the command line switch -v localVol:containerVol
docker run -d --name jenkins \
-u root \
-v /opt/docker/jenkins/jenkins_home:/var/jenkins_home \
-v /var/run/docker.sock:/var/run/docker.sock \
-v $(which docker):/usr/bin/docker \
-p 8080:8080 -p 50000:50000 \
jenkins/jenkins:lts
