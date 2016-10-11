#!/bin/bash

set -xe

TESTSUITE_REPO="${TESTSUITE_REPO:-https://github.com/indigo-iam/iam-robot-testsuite.git}"
TESTSUITE_BRANCH="${TESTSUITE_BRANCH:-master}"
OUTPUT_REPORTS="${OUTPUT_REPORTS:-reports}"

BROWSER="${BROWSER:-firefox}"
IAM_BASE_URL="${IAM_BASE_URL:-http://localhost:8080}"
REMOTE_URL="${REMOTE_URL:-}"

## Waiting for IAM
start_ts=$(date +%s)
timeout=300
sleeped=0

set +e
while true; do
    (curl --get $IAM_BASE_URL) >/dev/null 2>&1
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
	while true; do
	    (curl --get $REMOTE_URL) >/dev/null 2>&1
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
echo "Clone iam-robot-testsuite repository ..."
git clone $TESTSUITE_REPO

cd /home/tester/iam-robot-testsuite

echo "Switch branch ..."
git checkout $TESTSUITE_BRANCH

## Run
echo "Run ..."
pybot --pythonpath .:lib \
	--variable BROWSER:$BROWSER \
	--variable IAM_BASE_URL:$IAM_BASE_URL \
	--variable REMOTE_URL:$REMOTE_URL \
	-d $OUTPUT_REPORTS tests/

echo "Done."
