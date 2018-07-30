#!/usr/bin/env bash

set -e 

ARCH=$1

IMG_NAME=gohomeio/nsq

build(){
	docker build -t $IMG_NAME:$ARCH-latest --build-arg BUILD_IMAGE=${BUILD_IMAGE} --build-arg RUN_IMAGE=${RUN_IMAGE} .
	docker push $IMG_NAME:$ARCH-latest
}

case $ARCH in
amd64*)
	BUILD_IMAGE=golang:1.10.3-alpine3.8
	RUN_IMAGE=alpine:3.8
	build
	;;
arm32v6*)
	BUILD_IMAGE=arm32v6/golang:1.10.3-alpine3.8
	RUN_IMAGE=arm32v6/alpine:3.8
	build
	;;
manifest*)
	docker pull $IMG_NAME:arm32v6-latest
	docker manifest create $IMG_NAME:latest $IMG_NAME:arm32v6-latest $IMG_NAME:amd64-latest
	docker manifest annotate $IMG_NAME:latest $IMG_NAME:arm32v6-latest --os linux --arch arm
	docker manifest push $IMG_NAME:latest
	;;
*)
	echo "Unsupported"
	exit 1
	;;
esac