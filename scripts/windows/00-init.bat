@ECHO OFF

IF EXIST myCA ( RMDIR /Q /S myCA )

MD myCA
PUSHD myCA

MD newcerts
MD certs
MD crl
MD private

copy /B /Y NUL index.txt > NUL 2> NUL
echo 00> serial

POPD

@ECHO ON
