#!/bin/bash

set -xe

TESTSUITE_REPO="${TESTSUITE_REPO:-https://github.com/indigo-iam/iam-robot-testsuite.git}"
TESTSUITE_BRANCH="${TESTSUITE_BRANCH:-master}"
TESTSUITE_OPTS="${TESTSUITE_OPTS:-}"
OUTPUT_REPORTS="${OUTPUT_REPORTS:-reports}"

BROWSER="${BROWSER:-firefox}"
IAM_BASE_URL="${IAM_BASE_URL:-http://localhost:8080}"
IAM_TEST_CLIENT_URL="${IAM_TEST_CLIENT_URL:-http://localhost:9090/iam-test-client}"
REMOTE_URL="${REMOTE_URL:-}"
TIMEOUT="${TIMEOUT:-10}"
IMPLICIT_WAIT="${IMPLICIT_WAIT:-2}"
ADMIN_USER="${ADMIN_USER:-admin}"
ADMIN_PASSWORD="${ADMIN_PASSWORD:-password}"
CLIENT_ID="${CLIENT_ID:-client-cred}"
CLIENT_SECRET="${CLIENT_SECRET:-secret}"
TOKEN_EXCHANGE_CLIENT_ID="${TOKEN_EXCHANGE_CLIENT_ID:-token-exchange-actor}"
TOKEN_EXCHANGE_CLIENT_SECRET="${TOKEN_EXCHANGE_CLIENT_SECRET:-secret}"
IAM_HTTP_HOST="${IAM_HTTP_HOST:-localhost:8080}"
IAM_HTTP_SCHEME="${IAM_HTTP_SCHEME:-http}"

## Waiting for IAM
start_ts=$(date +%s)
timeout=300
sleeped=0

set +e
while true; do
    (curl -kIs --get $IAM_BASE_URL/login | egrep -q "200 OK|HTTP/2 200") 2>&1
    result=$?
    if [[ $result -eq 0 ]]; then
        end_ts=$(date +%s)
        echo "IAM is available after $((end_ts - start_ts)) seconds"
        break
    fi
    echo "Waiting for IAM..."
    sleep 5
    
    sleeped=$((sleeped+5))
    if [ $sleeped -ge $timeout  ]; then
    	echo "Timeout!"
    	exit 1
	fi
done
set -e

## Wait for Selenium Hub
if [ ! -z $REMOTE_URL ]; then
	start_ts=$(date +%s)
	timeout=300
	sleeped=0
	set +e
	url=`echo $REMOTE_URL | sed 's/wd\/hub//g'`
	while true; do
	    (curl -kIs --get $url | grep -q "200 OK") 2>&1
	    result=$?
	    if [[ $result -eq 0 ]]; then
	        end_ts=$(date +%s)
	        echo "Selenium Hub is available after $((end_ts - start_ts)) seconds"
	        break
	    fi
	    echo "Waiting for Selenium Hub..."
	    sleep 5
	    
	    sleeped=$((sleeped+5))
	    if [ $sleeped -ge $timeout  ]; then
	    	echo "Timeout!"
	    	exit 1
		fi
	done
	set -e
fi

## Clone testsuite code
if [ ! -d /home/tester/iam-robot-testsuite ]; then
	echo "Clone iam-robot-testsuite repository ..."
	git clone -b ${TESTSUITE_BRANCH} ${TESTSUITE_REPO} iam-robot-testsuite
fi

## Run
cd /home/tester/iam-robot-testsuite

echo "Run ..."
pybot --pythonpath .:lib \
	--variable BROWSER:${BROWSER} \
	--variable IAM_BASE_URL:${IAM_BASE_URL} \
	--variable REMOTE_URL:${REMOTE_URL} \
	--variable TIMEOUT:${TIMEOUT} \
	--variable IMPLICIT_WAIT:${IMPLICIT_WAIT} \
	--variable IAM_TEST_CLIENT_URL:${IAM_TEST_CLIENT_URL} \
	--variable ADMIN_USER:${ADMIN_USER} \
	--variable ADMIN_PASSWORD:${ADMIN_PASSWORD} \
	--variable CLIENT_ID:${CLIENT_ID} \
	--variable CLIENT_SECRET:${CLIENT_SECRET} \
	--variable TOKEN_EXCHANGE_CLIENT_ID:${TOKEN_EXCHANGE_CLIENT_ID} \
	--variable TOKEN_EXCHANGE_CLIENT_SECRET:${TOKEN_EXCHANGE_CLIENT_SECRET} \
	--variable IAM_HTTP_HOST:${IAM_HTTP_HOST} \
	--variable IAM_HTTP_SCHEME:${IAM_HTTP_SCHEME} \
	-d ${OUTPUT_REPORTS} ${TESTSUITE_OPTS} tests/

echo "Done."
