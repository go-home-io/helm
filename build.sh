#!/usr/bin/env bash

set -e 

skip_push=$1

img_build=
img_run=
targe_dir=
target_op=

BUILD_IMAGE=
RUN_IMAGE=
IMG_NAME=
ARCH=
GOARCH=
VERSION=ChangeMe

PS3='Select image:'
options=("nsq" "volantmq" "smartthings" "opensky" "heketi-ui" "chrome" "bintray-proxy" "Quit")
select opt in "${options[@]}"
do 
	targe_dir=$opt
	IMG_NAME=$opt
	case $opt in 
		"nsq")
			img_build=(golang:1.11.13-alpine3.9 
				arm32v7/golang:1.11.13-alpine3.9)
			img_run=(alpine:3.9 
				arm32v7/alpine:3.9)
			VERSION=1.1.0
		break
		;;
		"volantmq")
			img_build=(golang:1.11.13-alpine3.9 
				arm32v7/golang:1.11.13-alpine3.9)
			img_run=(alpine:3.9 
				arm32v7/alpine:3.9)
			VERSION=1.2.0
		break
		;;
		"smartthings")
			img_build=(nil nil)
			img_run=(node:10.7.0-alpine 
				arm32v6/node:9.6.1-alpine)
			VERSION=1.1.0
		break
		;;
		"opensky")
			img_build=(debian:jessie 
				arm32v7/debian:jessie)
			img_run=(debian:jessie-slim
				arm32v7/debian:jessie-slim)
			VERSION=1.0.0
		break
		;;
		"heketi-ui")
			img_build=(nil nil)
			img_run=(node:10.11.0-alpine
				arm32v6/node:10.11.0-alpine)
			VERSION=1.0.0		
		break
		;;
		"chrome")
			img_build=(nil nil)
			img_run=(debian:stretch
				arm32v7/debian:stretch)
			VERSION=1.0.0
		break
		;;
		"bintray-proxy")
			echo "WARNING: arm must be built on actual arm"
			img_build=(golang:1.11.0-alpine3.8 
				arm32v6/golang:1.11.0-alpine3.8)
			img_run=(alpine:3.8 
				arm32v6/alpine:3.8)
			VERSION=1.0.3
		break
		;;
		"Quit")
			exit 0
		;;
		*)
			echo "Invalid image"
			exit 1
		;;
	esac
done

IMG_NAME=gohomeio/${IMG_NAME}

echo "Curent version is ${VERSION}, concider increasing"

PS3='Select operation:'
options=("amd64" "arm32v6" "manifest" "Quit")
select opt in "${options[@]}"
do 
	ARCH=$opt
	case $opt in 
		"amd64")
			BUILD_IMAGE=${img_build[0]}
			RUN_IMAGE=${img_run[0]}
			GOARCH=amd64
		break
		;;
		"arm32v6")
			BUILD_IMAGE=${img_build[1]}
			RUN_IMAGE=${img_run[1]}
			GOARCH=arm
		break
		;;
		"manifest")
			docker pull $IMG_NAME:arm32v6-${VERSION}
			docker pull $IMG_NAME:amd64-${VERSION}
			docker manifest create $IMG_NAME:${VERSION} $IMG_NAME:arm32v6-${VERSION} $IMG_NAME:amd64-${VERSION} --amend
			docker manifest annotate $IMG_NAME:${VERSION} $IMG_NAME:arm32v6-${VERSION} --arch arm
			docker manifest push $IMG_NAME:${VERSION} 
			exit 0
		break
		;;
		"Quit")
			exit 0
		;;
		*)
			echo "Invalid arch"
			exit 1
		;;
	esac
done

cd ${targe_dir}/docker
docker build --no-cache -t $IMG_NAME:$ARCH-${VERSION} --build-arg BUILD_IMAGE=${BUILD_IMAGE} \
	--build-arg RUN_IMAGE=${RUN_IMAGE} --build-arg GOARCH=${GOARCH} .

if [ "${skip_push}" != "true" ]; then
	docker push $IMG_NAME:$ARCH-${VERSION}
fi;
