#!/bin/sh

set -e

IP_ADDR=192.168.56.78

# for CA
CONFIG_DIR="$( cd "$(dirname "$0")"/conf/ ; pwd -P )"
CA_DIR=/etc/pki/tls

# for server
SERVER_NAME=localhost
SERVER_DIR=/etc/pki/tls/$SERVER_NAME

help()
{
	echo "setup.sh <target>"
}

ca()
{
	echo create $CA_DIR
	mkdir -p $CA_DIR/{newcerts,crl}

	touch $CA_DIR/index.txt
	echo 00|tee $CA_DIR/serial

	echo create CA
	openssl req -config /etc/pki/tls/openssl.cnf \
		-new -x509 -sha256 -days 3650 -newkey rsa:4096 \
		-subj "/C=JP/ST=Kanagawa/L=Yokohama/O=Personal/CN=$IP_ADDR" \
		-out $CA_DIR/cacert.crt \
		-keyout $CA_DIR/private/cakey.pem

	echo remove passphrase
	openssl rsa \
		-in $CA_DIR/private/cakey.pem \
		-out $CA_DIR/private/cakey.pem
}

csr()
{
	rm -rf $SERVER_DIR

	mkdir -p $SERVER_DIR/private

	openssl req -new -sha256 -days 3650 \
		-newkey rsa:4096 \
		-subj "/C=JP/ST=Kanagawa/L=Yokohama/O=Personal/CN=$IP_ADDR" \
		-out $SERVER_DIR/$SERVER_NAME.csr \
		-keyout $SERVER_DIR/private/$SERVER_NAME.key

	openssl rsa -in $SERVER_DIR/private/$SERVER_NAME.key \
		-out $SERVER_DIR/private/$SERVER_NAME.key
}

crt()
{
	openssl ca -config ${CONFIG_DIR}/openssl.cnf \
		-days 3650 \
		-keyfile ${CA_DIR}/private/cakey.pem \
		-cert ${CA_DIR}/cacert.crt \
		-in ${SERVER_DIR}/${SERVER_NAME}.csr \
		-out ${SERVER_DIR}/${SERVER_NAME}.crt
}

p12()
{
	openssl pkcs12 \
		-export \
		-in ${SERVER_DIR}/${SERVER_NAME}.crt \
		-inkey ${SERVER_DIR}/private/${SERVER_NAME}.key \
		-out ${SERVER_DIR}/private/${SERVER_NAME}.p12
}

clean()
{
	rm -rf ${CA_DIR}/cacert.crt
	rm -rf ${CA_DIR}/${SERVER_NAME}
	rm -rf ${CA_DIR}/index.txt
	rm -rf ${CA_DIR}/serial
}


logfile=""

while getopts hvl: option
do
        case "$option" in
                h)
                        help
			exit 0;;
                v)
                        verbose=1;;
                l)
                        logfile=$OPTARG;;
                *)
                        echo unknown option "$option";;
        esac
done

shift $(($OPTIND-1))

if [ "x$logfile" != "x" ]; then
        echo logfile is $logfile
fi

for target in "$@" ; do
	type=`LC_ALL=C type -t $target || true`

	if [ "$type" = "function" ]; then
		$target
	else
		echo ERROR : target "$target" is not function, ignored.
		exit 1
	fi
done

