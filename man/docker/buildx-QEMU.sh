
# https://docs.docker.com/engine/reference/commandline/buildx/

# https://github.com/tonistiigi/binfmt

### 安装 QEMU all 等环境
docker run --privileged --rm tonistiigi/binfmt --install all
### 安装 QEMU arm64 等环境
docker run --privileged --rm tonistiigi/binfmt --install arm64,riscv64,arm
docker buildx ls

docker run --rm arm64v8/alpine:3.15.9 uname -a
# WARNING: The requested image's platform (linux/arm64) does not match the detected host platform (linux/amd64) and no specific platform was requested
  #Linux 869e16c62dd8 5.10.18-amd64-desktop #1 SMP Mon Mar 1 17:09:41 CST 2021 aarch64 Linux

# Usage:  docker buildx [OPTIONS] COMMAND
  #
  #Extended build capabilities with BuildKit
  #
  #Options:
  #      --builder string   Override the configured builder instance
  #
  #Management Commands:
  #  imagetools  Commands to work on images in registry
  #
  #Commands:
  #  bake        Build from a file
  #  build       Start a build
  #  create      Create a new builder instance
  #  du          Disk usage
  #  inspect     Inspect current builder instance
  #  ls          List builder instances
  #  prune       Remove build cache
  #  rm          Remove a builder instance
  #  stop        Stop builder instance
  #  use         Set the current builder instance
  #  version     Show buildx version information
