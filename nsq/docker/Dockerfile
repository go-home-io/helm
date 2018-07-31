ARG BUILD_IMAGE
ARG RUN_IMAGE
FROM $BUILD_IMAGE AS build

ENV COMMIT_HASH=8f3e47656ed54febe380486c0189c72af1bc9356

ENV GOOS=linux

ARG GOARCH
ENV GOARCH=$GOARCH

RUN apk update && apk add git make && \
	mkdir -p /go/src/github.com/nsqio && \
	cd /go/src/github.com/nsqio && \
	git clone https://github.com/nsqio/nsq.git && \
	cd nsq && \
	git reset --hard $COMMIT_HASH && \
	go get github.com/golang/dep/cmd/dep && \
	${GOPATH}/bin/dep ensure && \
	CGO_ENABLED=0 make DESTDIR=/opt PREFIX=/nsq GOFLAGS='-ldflags="-s -w"' install

##################################################################################################

FROM $RUN_IMAGE

EXPOSE 4150 4151 4160 4161 4170 4171

COPY --from=build /opt/nsq/bin/nsqd \
	/opt/nsq/bin/nsqadmin \
	/opt/nsq/bin/nsqlookupd /usr/local/bin/

RUN ln -s /usr/local/bin/*nsq* /