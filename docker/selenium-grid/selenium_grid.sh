#!/bin/bash

set -x

DOCKER_REGISTRY_HOST=${DOCKER_REGISTRY_HOST:-"cloud-vm128.cloud.cnaf.infn.it"}

function start(){
	net_options=""
	node_options=""
	
	if [ ! -z $DOCKER_NET_NAME ]; then
		net_options="--net $DOCKER_NET_NAME"
		node_options="-e HUB_PORT_4444_TCP_ADDR=selenium-hub -e HUB_PORT_4444_TCP_PORT=4444"
	else
		node_options="--link selenium-hub:hub"
	fi
	
	if [ ! -z $IAM_HOSTNAME ]; then
		iam_ip=`docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' iam`
		net_options="$net_options --add-host $IAM_HOSTNAME:$iam_ip"
	fi
	
	echo "Starting Hub..."
	docker run -d -e GRID_TIMEOUT=0 -p "4444:4444" $net_options --name selenium-hub --hostname selenium-hub selenium/hub
	
	sleep 5
	
	echo "Starting Chrome node..."
	docker run -d $net_options $node_options --name node-chrome selenium/node-chrome:2.53.0
	echo "Starting Firefox node..."
	docker run -d $net_options $node_options --name node-firefox selenium/node-firefox:2.53.0
}

function stop(){
	echo "Stopping containers..."
	docker stop selenium-hub node-chrome node-firefox
	
	echo "Deleting containers..."
	docker rm selenium-hub node-chrome node-firefox
}


case "$1" in
	start)
		start
		;;
	stop)
		stop
		;;
	*)
		echo "Usage: $0 {start|stop}"
		exit 1
esac
