## docker redis v6 / v7 with ssl example

```
# optionally create some new self signed certs
pushd redis
bash gen-redis-cert.sh
popd

export REDIS_VERSION=7.2

# start redis with ssl see: docker-redis-entrypoint.sh
docker compose up -d
```


Also see: 

- https://redis.io/docs/manual/security/encryption/


If you receive an error:

> # Error accepting a client connection: error:14094415:SSL routines:ssl3_read_bytes:sslv3 alert certificate expired

Run the `gen-redis-cert.sh` script as outlined above, and rebuild the container.


### connecting with TLS enabled

```

redis-cli --tls --cert ./redis/tls/redis.crt \
--key ./redis/tls/redis.key \
--cacert ./redis/tls/ca.crt --verbose

127.0.0.1:6379> info
# Server
redis_version:7.2
...
```
