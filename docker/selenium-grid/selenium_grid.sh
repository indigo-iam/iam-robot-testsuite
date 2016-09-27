#!/bin/bash

net_options=""

if [ ! -z $DOCKER_NET_NAME ]; then
	net_options="--net $DOCKER_NET_NAME"
fi

if [ ! -z $IAM_HOSTNAME ]; then
	IAM_HOST=`docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' iam`
	net_options="$net_options --add-host $IAM_HOSTNAME:$IAM_HOST"
fi

function start(){
	echo "Starting Hub..."
	docker run -d -p "4444:4444" $net_options --name selenium-hub --hostname selenium-hub selenium/hub
	
	start_ts=$(date +%s)
	timeout=300
	sleeped=0
	
	while true; do
	    (echo > /dev/tcp/localhost/4444) >/dev/null 2>&1
	    result=$?
	    if [[ $result -eq 0 ]]; then
	        end_ts=$(date +%s)
	        echo "Selenium Hub is available after $((end_ts - start_ts)) seconds"
	        break
	    fi
	    echo "Waiting for Hub..."
	    sleep 2
	done
	
	echo "Starting Chrome node..."
	docker run -d $net_options -e HUB_PORT_4444_TCP_ADDR=selenium-hub --name node-chrome selenium/node-chrome
	echo "Starting Firefox node..."
	docker run -d $net_options -e HUB_PORT_4444_TCP_ADDR=selenium-hub --name node-firefox selenium/node-firefox
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