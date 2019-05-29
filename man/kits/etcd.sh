#!/usr/bin/env bash

scp -r /eee/tmp/etcd.bin.tar.gz  oudream@10.31.58.75:/fff/etcd/
tar zxvf /fff/etcd/etcd.bin.tar.gz
PATH=${PATH}:/fff/etcd/bin

# On each etcd node, specify the cluster members:
# etcd
TOKEN=token-01
CLUSTER_STATE=new
NAME_1=machine-1
NAME_2=machine-2
NAME_3=machine-3
HOST_1=192.168.169.1
HOST_2=192.168.169.131
HOST_3=192.168.169.132
CLUSTER=${NAME_1}=http://${HOST_1}:2380,${NAME_2}=http://${HOST_2}:2380,${NAME_3}=http://${HOST_3}:2380

# Run this on each machine:
# For machine 1
THIS_NAME=${NAME_1}
THIS_IP=${HOST_1}
/fff/etcd/bin/etcd --data-dir=data.etcd --name ${THIS_NAME} \
	--initial-advertise-peer-urls http://${THIS_IP}:2380 --listen-peer-urls http://${THIS_IP}:2380 \
	--advertise-client-urls http://${THIS_IP}:2379 --listen-client-urls http://${THIS_IP}:2379 \
	--initial-cluster ${CLUSTER} \
	--initial-cluster-state ${CLUSTER_STATE} --initial-cluster-token ${TOKEN}

# For machine 2
THIS_NAME=${NAME_2}
THIS_IP=${HOST_2}
/fff/etcd/bin/etcd --data-dir=data.etcd --name ${THIS_NAME} \
	--initial-advertise-peer-urls http://${THIS_IP}:2380 --listen-peer-urls http://${THIS_IP}:2380 \
	--advertise-client-urls http://${THIS_IP}:2379 --listen-client-urls http://${THIS_IP}:2379 \
	--initial-cluster ${CLUSTER} \
	--initial-cluster-state ${CLUSTER_STATE} --initial-cluster-token ${TOKEN}

# For machine 3
THIS_NAME=${NAME_3}
THIS_IP=${HOST_3}
/fff/etcd/bin/etcd --data-dir=data.etcd --name ${THIS_NAME} \
	--initial-advertise-peer-urls http://${THIS_IP}:2380 --listen-peer-urls http://${THIS_IP}:2380 \
	--advertise-client-urls http://${THIS_IP}:2379 --listen-client-urls http://${THIS_IP}:2379 \
	--initial-cluster ${CLUSTER} \
	--initial-cluster-state ${CLUSTER_STATE} --initial-cluster-token ${TOKEN}


# 注意出现以下错误，是拷贝粘贴时要注意（mac 用原来的 TAB 不替换，而 linux 用 4 spaces来替换）
2019-05-27 03:42:31.939489 E | etcdmain: error verifying flags, 'etcd--initial-advertise-peer-urls' is not a valid flag. See 'etcd --help'.


# Now etcd is ready! To connect to etcd with etcdctl:
export ETCDCTL_API=3
HOST_1=192.168.169.1
HOST_2=192.168.169.131
HOST_3=192.168.169.132
ENDPOINTS=$HOST_1:2379,$HOST_2:2379,$HOST_3:2379

etcdctl --endpoints=$ENDPOINTS member list


# put command to write:
etcdctl --endpoints=$ENDPOINTS put foo "Hello World!"


# get to read from etcd:
etcdctl --endpoints=$ENDPOINTS get foo
etcdctl --endpoints=$ENDPOINTS --write-out="json" get foo
