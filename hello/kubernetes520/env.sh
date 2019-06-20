#!/usr/bin/bash

# 生成 EncryptionConfig 所需的加密 key
export ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)

# 集群各机器 IP 数组
export NODE_IPS=(172.16.11.1 172.16.11.130 172.16.11.131)

# 集群各 IP 对应的主机名数组
export NODE_NAMES=(oudream-ubuntu1 vm-ubuntu1 vm-ubuntu2)

# etcd 集群服务地址列表
export ETCD_ENDPOINTS="https://172.16.11.1:2379,https://172.16.11.130:2379,https://172.16.11.131:2379"

# etcd 集群间通信的 IP 和端口
export ETCD_NODES="oudream-ubuntu1=https://172.16.11.1:2380,vm-ubuntu1=https://172.16.11.130:2380,vm-ubuntu2=https://172.16.11.131:2380"

# kube-apiserver 的反向代理(kube-nginx)地址端口
export KUBE_APISERVER="https://127.0.0.1:8443"

# 节点间互联网络接口名称
export IFACE="vmnet8"
export IFACE="ens33"

# etcd 数据目录
export ETCD_DATA_DIR="/eee/kubernetes/etcd/data"

# etcd WAL 目录，建议是 SSD 磁盘分区，或者和 ETCD_DATA_DIR 不同的磁盘分区
export ETCD_WAL_DIR="/eee/kubernetes/etcd/wal"

# kubernetes 各组件数据目录
export K8S_DIR="/fff/kubernetes"

# docker 数据目录
export DOCKER_DIR="/kubernetes/docker"

## 以下参数一般不需要修改

# TLS Bootstrapping 使用的 Token，可以使用命令 head -c 16 /dev/urandom | od -An -t x | tr -d ' ' 生成
BOOTSTRAP_TOKEN="d6d81c035636f23e32bda1b240c40187"

# 最好使用 当前未用的网段 来定义服务网段和 Pod 网段

# 服务网段，部署前路由不可达，部署后集群内路由可达(kube-proxy 保证)
SERVICE_CIDR="10.254.0.0/16"

# Pod 网段，建议 /16 段地址，部署前路由不可达，部署后集群内路由可达(flanneld 保证)
CLUSTER_CIDR="172.30.0.0/16"

# 服务端口范围 (NodePort Range)
export NODE_PORT_RANGE="30000-32767"

# flanneld 网络配置前缀
export FLANNEL_ETCD_PREFIX="/kubernetes/network"

# kubernetes 服务 IP (一般是 SERVICE_CIDR 中第一个IP)
export CLUSTER_KUBERNETES_SVC_IP="10.254.0.1"

# 集群 DNS 服务 IP (从 SERVICE_CIDR 中预分配)
export CLUSTER_DNS_SVC_IP="10.254.0.2"

# 集群 DNS 域名（末尾不带点号）
export CLUSTER_DNS_DOMAIN="cluster.local"

# 将二进制目录 /fff/kubernetes/bin 加到 PATH 中
export PATH=/fff/kubernetes/bin:$PATH
