ARG BUILD_IMAGE
ARG RUN_IMAGE
FROM $BUILD_IMAGE AS build

ENV GOOS=linux

ARG GOARCH
ENV GOARCH=$GOARCH

RUN apk update && apk add git gcc musl-dev binutils-gold && \
 	go get -v github.com/ahmetb/govvv && \
 	go get -v github.com/VolantMQ/vlapi/... && \
 	go get -v github.com/VolantMQ/volantmq && \
	cd /go/src/github.com/VolantMQ/volantmq && \
	govvv build -i -o /volantmq/volantmq && \ 
	cd ../vlapi/plugin/health && \
	go build -i -buildmode=plugin -o /volantmq/plugins/health.so

##################################################################################################

FROM $RUN_IMAGE

ENV VOLANTMQ_PLUGINS_DIR=/usr/local/bin/plugins/

COPY --from=build /volantmq/ /usr/local/bin/

RUN ln -s /usr/local/bin/volantmq /

EXPOSE 1883
CMD ["volantmq"]