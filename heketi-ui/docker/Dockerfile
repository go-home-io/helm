ARG RUN_IMAGE
FROM $RUN_IMAGE

ENV COMMIT_HASH=8d4fbf5c8daf56d863e76b09f900e503bfcb5bfd \
	HEKETI_SERVER_URL= \
	HEKETI_SERVER_USER=admin \
	HEKETI_SERVER_SECRET=

RUN apk update && \
	apk add --no-cache --virtual .build-deps git && \
	apk add --no-cache ca-certificates && \
	git clone https://github.com/orachide/heketi-ui.git && \
	cd heketi-ui && \
	git reset --hard $COMMIT_HASH && \
	rm -rf .git && \
	npm i && \ 
	npm run-script build && \
	npm prune --production && \
	apk del .build-deps

WORKDIR /heketi-ui

EXPOSE 3000

CMD ["npm", "start"]