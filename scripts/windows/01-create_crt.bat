@ECHO OFF
SETLOCAL

PUSHD myCA

openssl req -config C:/opt/ssl/openssl.cnf ^
	-new -x509 -sha256 -days 3650 -newkey rsa:4096 ^
	-subj "/C=JP/ST=Kanagawa/L=Yokohama/O=Personal/CN=192.168.11.93" ^
	-out cacert.pem -keyout private/cakey.pem

openssl rsa -in private/cakey.pem -out private/cakey.pem

POPD

ENDLOCAL

@ECHO ON
