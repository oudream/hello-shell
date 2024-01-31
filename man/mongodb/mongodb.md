
###
  -p 20117:27017 \
```shell
docker run --name mongo \
  -v /mnt/sda2/mongodb/data:/data/db \
  -v /mnt/sda2/mongodb/conf:/data/conf \
  -p 20117:27017 \
  -e TZ=Asia/Shanghai \
  --restart=always \
  -itd mongo:5.0.23 
```