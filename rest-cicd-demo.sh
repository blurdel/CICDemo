#!/bin/bash

me=$(basename $0)
echo "me: ${me} $@"

if [[ $# -ne 2 ]]; then
  echo "Usage: ${me} <jobname> <branch>"
  exit
fi

job=${1}
branch=${2}

URL="http://localhost:8080/job/${job}/job/${branch}/buildWithParameters?param1=p1&version=1.1.0&unitTests=true"
echo "URL: ${URL}"

ret=$(curl -X POST -vL --user auto:11472f530977d43e7f45ba5642d7fe7750  "${URL}")
echo "retVal=$?"
