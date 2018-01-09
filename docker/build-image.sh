#!/bin/bash

USER_UID="${USER_UID:-10000}"
IMAGE_NAME="${TESTSUITE_IMAGE_NAME:-indigoiam/iam-robot-testsuite}"

docker build --no-cache --build-arg USER_UID=${USER_UID} -t ${IMAGE_NAME} .
