@ECHO OFF
SETLOCAL

PUSHD myCA

openssl req -config C:/opt/ssl/openssl.cnf ^
	-new -sha256 -days 3650 -newkey rsa:4096 ^
	-subj "/C=JP/ST=Kanagawa/L=Yokohama/O=Personal/CN=192.168.11.93" ^
	-out server.csr -keyout private/server.key

openssl rsa -in private/server.key -out private/server.key

POPD

ENDLOCAL

@ECHO ON
