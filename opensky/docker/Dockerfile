ARG BUILD_IMAGE
ARG RUN_IMAGE
FROM $BUILD_IMAGE AS build

RUN apt-get update && \
	apt-get install -y --no-install-recommends ca-certificates git build-essential cmake libusb-1.0.0-dev librtlsdr-dev debhelper pkg-config wget && \
	wget -O - https://opensky-network.org/files/firmware/opensky.gpg.pub > key.pub && \
	git clone git://git.osmocom.org/rtl-sdr.git && \
	cd rtl-sdr && \
	dpkg-buildpackage && \
	cd .. && \
	git clone https://github.com/mutability/dump1090.git && \
	cd dump1090 && \
	dpkg-buildpackage

##################################################################################################

FROM $RUN_IMAGE

ENV LAT=37.927593 \
	LON=-122.319313 \
	ALT=29 \
	DEBIAN_FRONTEND=noninteractive \
	SERIAL=-serial \
	OPENSKY_USER=

COPY --from=build /*.deb /
COPY --from=build /key.pub / 

ADD index.html /var/www/html/
ADD start.sh /
ADD health.sh /

RUN apt-get update && \
	apt-get install -y --no-install-recommends apt-transport-https ca-certificates lighttpd libusb-1.0.0-dev && \
	echo 'blacklist dvb_usb_rtl28xxu blacklist rtl2832 blacklist rtl2830' > /etc/modprobe.d/block.conf && \
	dpkg -i /librtlsdr* && \
	dpkg -i dump1090*.deb && \
	cat key.pub | apt-key add - && \
	echo deb https://opensky-network.org/repos/debian opensky custom > /etc/apt/sources.list.d/opensky.list && \
	apt-get update && \
	echo 'opensky-feeder openskyd/latitude string 2' >> preseed.txt && \
 	echo 'opensky-feeder openskyd/longitude string 2' >> preseed.txt && \
 	echo 'opensky-feeder openskyd/altitude string 1' >> preseed.txt && \
 	echo 'opensky-feeder openskyd/username string' >> preseed.txt && \
 	echo 'opensky-feeder openskyd/serial string' >> preseed.txt && \
 	echo 'opensky-feeder openskyd/port string' >> preseed.txt && \
 	echo 'opensky-feeder openskyd/host string' >> preseed.txt && \
 	debconf-set-selections preseed.txt && \
	apt-get install -y opensky-feeder && \
	mkdir /run/dump1090-mutability && \
	chmod +x start.sh health.sh

EXPOSE 80 30003 30005 30104

CMD ["/start.sh"]