#!/usr/bin/env bash

### docker
# docker-server control
service docker start
systemctl start docker
service docker stop
systemctl stop docker
docker run -t -i ubuntu /bin/bash # start ubuntu in interaction
docker exec -it $ContainerID /bin/bash
docker ps -a
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $INSTANCE_ID # Get an instance’s IP address
docker inspect --format='{{range .NetworkSettings.Networks}}{{.MacAddress}}{{end}}' $INSTANCE_ID # Get an instance’s MAC address
docker inspect --format='{{.LogPath}}' $INSTANCE_ID # Get an instance’s log path
docker system prune -a # clean cache
docker volume create portainer_data
docker run -d -p 9000:9000 --restart=always --name portainer -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer
# Folder Directory
#~/Library/Containers/com.docker.docker
#/var/lib/docker
