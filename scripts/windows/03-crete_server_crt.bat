@ECHO OFF
SETLOCAL

PUSHD myCA

openssl ca -config C:/opt/ssl/openssl.cnf ^
	-days 3650 ^
	 -keyfile private/cakey.pem ^
	-cert cacert.pem -in server.csr -out server.crt

POPD

ENDLOCAL

@ECHO ON
