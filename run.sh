#!/bin/bash
cd redis
./gen-redis-certs.sh 
export REDIS_VERSION=7.2
docker pull redis:7.2
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
docker compose up -d
echo "REDIS PASSWORD: $REDIS_PASSWORD"
