#!/bin/bash
cd redis
./gen-redis-certs.sh 
export REDIS_VERSION=6.2.14
docker pull redis:6.2.14
cd ..
if [ "$(uname)" == "Darwin" ]; then
	REDIS_PASSWORD=$(uuidgen | shasum | cut -d':' -f3 | cut -d' ' -f1) 
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	REDIS_PASSWORD=$(uuidgen | sha256sum | cut -d' ' -f1)
fi
echo "requirepass $REDIS_PASSWORD" > redis.conf
echo "tls-port 6379" >> redis.conf
echo "port 0" >> redis.conf
echo "tls-cert-file /tls/redis.crt" >> redis.conf
echo "tls-key-file /tls/redis.key" >> redis.conf
echo "tls-ca-cert-file /tls/ca.crt" >> redis.conf
echo "tls-auth-clients no" >> redis.conf
echo "tls-protocols \"TLSv1.1 TLSv1.2\"" >> redis.conf
echo "tls-prefer-server-ciphers yes" >> redis.conf
docker-compose up -d
echo "REDIS_PASSWORD:$REDIS_PASSWORD"
