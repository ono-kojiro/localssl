#!/bin/sh

# cwd is /mingw64/ssl

rm -rf myCA

mkdir -p myCA
mkdir -p myCA/newcerts
mkdir -p myCA/certs
mkdir -p myCA/crl
mkdir -p myCA/private
chmod 700 myCA/private

touch myCA/index.txt
echo 00|tee myCA/serial


