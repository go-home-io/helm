#!/usr/bin/env bash

set -e 

service_up(){
	svc_name=$1
	is_up=$(ps -ef | grep -v grep | grep ${svc_name} | wc -l)
	if [ "0" = "${is_up}" ]; then 
		exit 1
	fi;
}

service_up lighttpd
service_up dump1090-mutability
service_up openskyd-dump1090