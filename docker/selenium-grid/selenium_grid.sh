#!/bin/bash

function start(){
	echo "Starting Hub..."
	docker run -d -p "4444:4444" --name selenium-hub selenium/hub
	
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
	    echo "Waiting for PAP..."
	    sleep 2
	done
	
	echo "Starting Chrome node..."
	docker run -d --link selenium-hub:hub --name node-chrome selenium/node-chrome
	echo "Starting Firefox node..."
	docker run -d --link selenium-hub:hub --name node-firefox selenium/node-firefox
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