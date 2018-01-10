#!/bin/bash
IMAGE_NAME="${TESTSUITE_IMAGE_NAME:-indigoiam/iam-robot-testsuite}"
docker build --no-cache -t ${IMAGE_NAME} .
