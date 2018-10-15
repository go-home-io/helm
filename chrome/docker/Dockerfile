ARG RUN_IMAGE
FROM $RUN_IMAGE

RUN apt-get update && apt-get install -y ca-certificates chromium=63.0.3239.84-1~deb9u1

EXPOSE 9222

CMD ["chromium", "--addr=localhost", "--port=9222", "--remote-debugging-port=9222", \
	"--remote-debugging-address=0.0.0.0", "--disable-extensions", "--disable-gpu", \
	"--hide-scrollbars", "--no-first-run", "--mute-audio", \
	"--no-sandbox", "--headless"]