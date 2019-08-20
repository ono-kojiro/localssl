#!/bin/sh

openssl ca -config /usr/ssl/openssl.cnf \
	-days 3650 \
	 -keyfile private/cakey.pem \
	-cert cacert.pem -in server.csr -out server.crt

