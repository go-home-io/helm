#!/usr/bin/env bash

set -e 


img_build=
img_run=
targe_dir=
target_op=

BUILD_IMAGE=
RUN_IMAGE=
IMG_NAME=
ARCH=

PS3='Select image:'
options=("nsq" "volantmq" "Quit")
select opt in "${options[@]}"
do 
	targe_dir=$opt
	case $opt in 
		"nsq")
			img_build=(golang:1.10.3-alpine3.8 
				arm32v6/golang:1.10.3-alpine3.8)
			img_run=(alpine:3.8 
				arm32v6/alpine:3.8)
			IMG_NAME=nsq
		break
		;;
		"volantmq")
			img_build=(golang:1.11beta1-alpine3.8 
				arm32v6/golang:1.11beta1-alpine3.8)
			img_run=(alpine:3.8 
				arm32v6/alpine:3.8)
			IMG_NAME=volantmq
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

PS3='Select operation:'
options=("amd64" "arm32v6" "manifest" "Quit")
select opt in "${options[@]}"
do 
	ARCH=$opt
	case $opt in 
		"amd64")
			BUILD_IMAGE=${img_build[0]}
			RUN_IMAGE=${img_run[0]}
		break
		;;
		"arm32v6")
			BUILD_IMAGE=${img_build[1]}
			RUN_IMAGE=${img_run[1]}
		break
		;;
		"manifest")
			docker pull $IMG_NAME:arm32v6-latest
			docker pull $IMG_NAME:amd64-latest
			docker manifest create $IMG_NAME:latest $IMG_NAME:arm32v6-latest $IMG_NAME:amd64-latest
			docker manifest annotate $IMG_NAME:latest $IMG_NAME:arm32v6-latest --os linux --arch arm
			docker manifest push $IMG_NAME:latest
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
docker build -t $IMG_NAME:$ARCH-latest --build-arg BUILD_IMAGE=${BUILD_IMAGE} --build-arg RUN_IMAGE=${RUN_IMAGE} .
docker push $IMG_NAME:$ARCH-latest
