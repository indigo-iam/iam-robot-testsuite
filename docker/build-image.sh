#!/bin/bash

USER_UID="${USER_UID:-10000}"

docker build --no-cache --build-arg USER_UID=${USER_UID} -t italiangrid/iam-robot-testsuite .
