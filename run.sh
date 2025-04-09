#!/bin/bash
cd redis
./gen-redis-certs.sh 
export REDIS_VERSION=7.2
docker pull redis:7.2
cd ..
docker compose up -d

