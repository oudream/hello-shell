#!/bin/sh

export DOCKER_CLI_EXPERIMENTAL=enabled
export DOCKER_BUILDKIT=1
#docker buildx create --use --name mybuilder
#docker buildx build --platform linux/amd64,linux/arm64 --progress=plain -t myapp -o type=docker,dest=- . > myimage.tar
docker buildx build -f Dockerfile -t hy3:1.1.5 --platform=linux/arm64 . --load
docker save -o hy3.tar hy3:1.1.5
docker load -i hy3.tar hy3:1.1.5
