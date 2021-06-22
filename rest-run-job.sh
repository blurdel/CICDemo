#!/bin/bash

me=$(basename $0)
echo "me: ${me} $@"

if [[ $# -ne 2 ]]; then
  echo "Usage: ${me} <jobname> <branch>"
  exit
fi

job=${1}
branch=${2}
echo "ARG: ${job}, ${branch}"

URL="http://localhost:8080/job/${job}/job/${branch}/build"
echo "URL: ${URL}"

ret=$(curl -X POST -vL --user auto:11472f530977d43e7f45ba5642d7fe7750  "${URL}")
echo "retVal=$?"


#curl -X POST -vL --show-error --user auto:11472f530977d43e7f45ba5642d7fe7750  http://localhost:8080/job/CICD-demo/job/master/buildWithParameters?param1=a&version=1.1&unitTests=true

# "curl -X GET -vL  http://localhost:8080/api/json?pretty=true  --user auto:11472f530977d43e7f45ba5642d7fe7750"

#crumb=$(curl -s 'http://USERNAME:API_TOKEN@JENKINS_URL/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')
#curl -X POST -H "$crumb" "http://USERNAME:API_TOKEN@JENKINS_URL/job/JOB_NAME/build"
