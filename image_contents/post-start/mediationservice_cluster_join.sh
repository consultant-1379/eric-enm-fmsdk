#!/bin/bash

readonly CURL="/usr/bin/curl"
HTTP_PORT="8080"
HOSTNAME=`hostname`

JOIN_CLUSTER_URL="http://$HOSTNAME:$HTTP_PORT/mediationservice/res/cluster/join"

#MAIN
logger "Running curl command to join in mediationservice-router cluster"
response=$($CURL -m 10 --write-out %"{http_code}" --connect-timeout 3 --silent --output /dev/null "$JOIN_CLUSTER_URL")
logger "Response code $response is received for the command $JOIN_CLUSTER_URL"
exit 0
