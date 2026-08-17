#!/usr/bin/env bash


### 简单部署
```shell
mkdir -p /opt/jenkins_home
cd /opt

docker run -d \
  --name jenkins \
  --restart unless-stopped \
  -p 6080:8080 \
  -p 50000:50000 \
  -v /opt/jenkins_home:/var/jenkins_home \
  jenkins/jenkins:2.555.1-lts
```

### 若你打算在 Jenkins 中 docker build、docker push，通常还会挂：
- -v /var/run/docker.sock:/var/run/docker.sock
```shell
docker run -d \
  --name jenkins \
  --restart unless-stopped \
  -p 6080:8080 \
  -p 50000:50000 \
  -v /opt/jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkins/jenkins:lts-jdk21
  
  docker pull jenkins/jenkins:2.555.1-lts
```