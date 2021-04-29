#!/bin/bash

# First need to make the local volume (localVol), docker will do it but with root permissions
# The local volume can be found after the command line switch -v localVol:containerVol
docker run --name local_jenkins -d -p 8443:8080 -p 50000:50000 -v /opt/docker/jenkins/jenkins_home:/var/jenkins_home  jenkins/jenkins:lts
