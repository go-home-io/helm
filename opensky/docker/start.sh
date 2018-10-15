#!/usr/bin/env bash

service lighttpd start

dump1090-mutability --lat ${LAT} --lon ${LON} --quiet --net --net-sbs-port 30003 --write-json /run/dump1090-mutability \
	--write-json-every 1 --json-location-accuracy 2 &

debconf-set-selections <<< "opensky-feeder openskyd/latitude string ${LAT}"
debconf-set-selections <<< "opensky-feeder openskyd/longitude string ${LON}"
debconf-set-selections <<< "opensky-feeder openskyd/altitude string ${ALT}"
debconf-set-selections <<< "opensky-feeder openskyd/serial string ${SERIAL}"
[[ ! -z ${OPENSKY_USER} ]] && debconf-set-selections <<< "opensky-feeder openskyd/username string ${OPENSKY_USER}" || OPENSKY_USER=""

dpkg-reconfigure opensky-feeder
openskyd-dump1090