#!/bin/bash

set -xe

TESTSUITE_REPO="${TESTSUITE_REPO:-https://github.com/indigo-iam/iam-robot-testsuite.git}"
TESTSUITE_BRANCH="${TESTSUITE_BRANCH:-master}"
OUTPUT_REPORTS="${OUTPUT_REPORTS:-reports}"

BROWSER="${BROWSER:-firefox}"
IAM_BASE_URL="${IAM_BASE_URL:-http://localhost:8080}"
REMOTE_URL="${REMOTE_URL:-}"

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
