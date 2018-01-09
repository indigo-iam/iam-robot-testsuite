#!/bin/sh
set -xe

TESTSUITE_IMAGE_NAME=${TESTSUITE_IMAGE_NAME:-indigoiam/iam-robot-testsuite:latest}

if [ -n "${DOCKER_REGISTRY_HOST}" ]; then
  image_name=${DOCKER_REGISTRY_HOST}/${TESTSUITE_IMAGE_NAME}
  docker tag ${image_name} ${TESTSUITE_IMAGE_NAME}
  docker push ${image_name}
else 
  docker push ${TESTSUITE_IMAGE_NAME}
fi
