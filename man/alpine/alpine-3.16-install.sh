### redis amd64-alpine 7.0.5
cd /opt/dev/3rd
git clone https://github.com/redis/redis.git redis-amd64-alpine
cd /opt/dev/3rd/redis-amd64-alpine
git checkout 1571907
make MALLOC=libc
mkdir -p /opt/dev/deploy/amd64-alpine/redis/
cp src/redis-server /opt/dev/deploy/amd64-alpine/redis/
cp src/redis-cli /opt/dev/deploy/amd64-alpine/redis/
cp src/redis-check-aof /opt/dev/deploy/amd64-alpine/redis/
cp src/redis-check-rdb /opt/dev/deploy/amd64-alpine/redis/
cp src/redis-sentinel /opt/dev/deploy/amd64-alpine/redis/
cp src/redis-benchmark /opt/dev/deploy/amd64-alpine/redis/


## mqtt
cd /opt/dev/3rd
git clone https://github.com/eclipse/mosquitto.git
git clone https://github.com/troydhanson/uthash.git
cp uthash/src/* mosquitto/include
cd mosquitto
git checkout fd0e398
# build amd64-alpine
cd /opt/dev/3rd/mosquitto
rm -rf cmake-build-amd64-alpine && mkdir cmake-build-amd64-alpine &&cd cmake-build-amd64-alpine
cmake -DWITH_CJSON=no -DWITH_TLS=no -DWITH_BUNDLED_DEPS=no -DWITH_DOCS=no -DDOCUMENTATION=OFF ..
make -j 8
mkdir -p /opt/dev/deploy/amd64-alpine/mosquitto/
cp src/mosquitto /opt/dev/deploy/amd64-alpine/mosquitto/
cp client/mosquitto_pub /opt/dev/deploy/amd64-alpine/mosquitto/
cp client/mosquitto_rr /opt/dev/deploy/amd64-alpine/mosquitto/
cp client/mosquitto_sub /opt/dev/deploy/amd64-alpine/mosquitto/
cp lib/libmosquitto.so.1 /opt/dev/deploy/amd64-alpine/mosquitto/
