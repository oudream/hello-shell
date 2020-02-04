#!/usr/bin/env bash


https://portainer.readthedocs.io/en/latest/deployment.html


# Quick start
docker volume create portainer_data
docker run -d -p 9000:9000 -p 8000:8000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
docker run -d -p 2211:9000 -p 2210:8000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer

username: admin
pwd: 13524666

# Manage the Docker environment where Portainer is running.
# Ensure that you have started the Portainer container with the following Docker flag:
# -v "/var/run/docker.sock:/var/run/docker.sock" (Linux).
# or
# -v \\.\pipe\docker_engine:\\.\pipe\docker_engine (Windows).
