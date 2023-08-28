#!/usr/bin/env bash


https://portainer.readthedocs.io/en/latest/deployment.html

# portainer
docker run -d -p 9000:9000 --restart=always --name portainer -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer:1.23.2

docker run -d -p 9000:9000 -p 8000:8000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /userdata/portainer/data:/data -v /userdata/portainer/public:/public portainer/portainer:1.24.2

docker run -d -p 9000:9000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data -v /public:/public portainer/portainer:linux-arm64

docker run -d -p 9000:9000 --restart=always --name portainer -v /var/run/docker/containerd/containerd.sock:/var/run/docker.sock -v /userdata/portainer:/data portainer/portainer:1.23.2
docker run -d \
  -p 9001:9001 \
  --name portainer_agent \
  --restart=always \
  -v /var/run/docker/containerd/containerd.sock:/var/run/docker.sock \
  -v /var/lib/docker/volumes:/var/lib/docker/volumes \
  portainer/agent:2.16.2

docker pull portainer/portainer:1.23.2

# ce
# docker run -d -p 8000:8000 -p 9000:9000 --name portainer --restart=always -v /var/run/docker/containerd/containerd.sock:/var/run/docker.sock -v /userdata/portainer:/data portainer/portainer-ce
# Quick start
docker volume create portainer_data
docker run -d -p 9900:9000 -p 8900:8000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
docker run -d -p 9000:9000 -p 8000:8000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
docker run -d -p 2211:9000 -p 2210:8000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
docker run -d -p 9211:9000 -p 9210:8000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
open http://localhost:2211/

username: admin
pwd: 13524666

# Manage the Docker environment where Portainer is running.
# Ensure that you have started the Portainer container with the following Docker flag:
# -v "/var/run/docker.sock:/var/run/docker.sock" (Linux).
# or
# -v \\.\pipe\docker_engine:\\.\pipe\docker_engine (Windows).
