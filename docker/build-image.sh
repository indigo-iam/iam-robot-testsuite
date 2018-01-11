#!/bin/bash
IMAGE_NAME="${TESTSUITE_IMAGE_NAME:-indigoiam/iam-robot-testsuite}"
docker build -t ${IMAGE_NAME} .
