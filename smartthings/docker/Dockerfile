ARG RUN_IMAGE
FROM $RUN_IMAGE

ENV COMMIT_HASH=c7034ca7c993d0a8c69a03bea7e7cc0461b5a280 \
	MOUNT_VOL=/mount \
	MOUNT_CFG=/config

ADD start.sh /start.sh

RUN apk update && \
	apk add --no-cache --virtual .build-deps git && \
	apk add --no-cache ca-certificates && \
	git clone https://github.com/stjohnjohnson/smartthings-mqtt-bridge.git && \
	cd smartthings-mqtt-bridge && \
	git reset --hard $COMMIT_HASH && \
	rm -rf .git && \
	npm i --production && \ 
	apk del .build-deps && \
	mv -f /start.sh . && \
	chmod +x start.sh

WORKDIR /smartthings-mqtt-bridge

EXPOSE 8080
CMD ["./start.sh"]