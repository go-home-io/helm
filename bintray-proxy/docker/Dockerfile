ARG BUILD_IMAGE
ARG RUN_IMAGE
FROM $BUILD_IMAGE AS build

ENV GOOS=linux

ARG GOARCH
ENV GOARCH=$GOARCH

RUN apk update && apk add git && \
	mkdir -p /go/src/github.com/go-home-io && \
	cd /go/src/github.com/go-home-io && \
	git clone https://github.com/go-home-io/server.git && \
	cd server/cmd/proxy && \
	go get . && \
	go build -o /proxy download.go

##################################################################################################

FROM $RUN_IMAGE

ENV MOUNT_PATH=/plugins

COPY --from=build /proxy /

RUN apk update && apk add ca-certificates

EXPOSE 9090

CMD ["/bin/sh", "-c", "/proxy ${MOUNT_PATH} 9090"]