### 在arm64上构建arm64的docker镜像文件


### buildx 的跨平台构建策略，根据构建节点和目标程序语言不同，buildx 支持以下三种跨平台构建策略：
- 1、通过 QEMU 的用户态模式创建轻量级的虚拟机，在虚拟机系统中构建镜像。
- 2、在一个 builder 实例中加入多个不同目标平台的节点，通过原生节点构建对应平台镜像。
- 3、分阶段构建并且交叉编译到不同的目标架构。


### 方式 1、QEMU 通常用于模拟完整的操作系统，它还可以通过用户态模式运行：
- 这种方式不需要对已有的 Dockerfile 做任何修改，实现的成本很低，但显而易见效率并不高。
> 以 binfmt_misc 在宿主机系统中注册一个二进制转换处理程序，并在程序运行时动态翻译二进制文件，
> 根据需要将系统调用从目标 CPU 架构转换为当前系统的 CPU 架构。最终的效果就像在一个虚拟机中运行目标 CPU 架构的二进制文件。
> Docker Desktop 内置了 QEMU 支持，其他满足运行要求的平台可通过以下方式安装：
```shell
docker run --privileged --rm tonistiigi/binfmt --install all
```


### 方式 3、阶段构建并且交叉编译到不同的目标架构
> 构建过程分为两个阶段：  
> 在一阶段中，我们将拉取一个和当前构建节点相同平台的 golang 镜像，并使用 Go 的交叉编译特性将其编译为目标架构的二进制文件。  
> 然后拉取目标平台的 alpine 镜像，并将上一阶段的编译结果拷贝到镜像中。
- 1 step : 使用 docker buildx create 命令可以创建 builder 实例，这将以当前使用的 docker 服务为节点创建一个新的 builder 实例。
```shell
docker buildx create --driver docker-container --platform linux/amd64 --name multi-builder
```
- 2 step : 刚创建的 builder 处于 inactive 状态，可以在 create 或 inspect 子命令中添加 --bootstrap 选项立即启动实例（可验证节点是否可用）
```shell
docker buildx inspect --bootstrap multi-builder

## 将列出所有可用的 builder 实例和实例中的节点：
docker buildx ls

## docker buildx use <builder> 将切换到所指定的 builder 实例
docker buildx use multi-builder
```
- 3 step : 去到目录 【 demo--platform 】中运行
```shell
### 输出到本地 docker images 中
docker buildx build --platform linux/amd64 -t hello-buildx-amd64:1.0.1 --load .
docker buildx build --platform linux/arm64 -t hello-buildx-arm64:1.0.1 --load .
docker buildx build --platform linux/arm -t hello-buildx-arm:1.0.1 --load .
### 推到仓库
# docker buildx build --platform linux/amd64,linux/arm64,linux/arm -t registry.cn-hangzhou.aliyuncs.com/waynerv/arch-demo -o type=registry .
```
