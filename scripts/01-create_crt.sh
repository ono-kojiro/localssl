#!/bin/sh

openssl req -config /usr/ssl/openssl.cnf \
	-new -x509 -sha256 -days 3650 -newkey rsa:4096 \
	-subj "/C=JP/ST=Kanagawa/L=Yokohama/O=Personal/CN=192.168.11.93" \
	-out cacert.pem -keyout private/cakey.pem


