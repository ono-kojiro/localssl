#!/bin/sh

openssl req -new -sha256 -days 3650 \
	-newkey rsa:4096 \
	-subj "/C=JP/ST=Kanagawa/L=Yokohama/O=Personal/CN=192.168.11.93" \
	-out server.csr -keyout private/server.key



