#!/usr/bin/env bash


### first define env.sh
source env.sh

### hosts

# 172.16.11.1   oudream-ubuntu1
# 172.16.11.130 vm-ubuntu1
# 172.16.11.131 vm-ubuntu2

cat >> /etc/hosts <<EOF
172.16.11.1 oudream-ubuntu1
172.16.11.130 vm-ubuntu1
172.16.11.131 vm-ubuntu2
EOF


### user
# useradd -m docker
# create user docker and append to group docker
useradd -g docker -m docker



### ssh login with no password
ssh-keygen -t rsa
ssh-copy-id oudream@oudream-ubuntu1
ssh-copy-id oudream@vm-ubuntu1
ssh-copy-id oudream@vm-ubuntu2
ssh-copy-id root@oudream-ubuntu1
ssh-copy-id root@vm-ubuntu1
ssh-copy-id root@vm-ubuntu2
ssh-copy-id oudream@ics-ubuntu1
ssh-copy-id oudream@ics-ubuntu2
ssh-copy-id oudream@ics-ubuntu3
ssh-copy-id root@ics-ubuntu1
ssh-copy-id root@ics-ubuntu2
ssh-copy-id root@ics-ubuntu3
# cat ~/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys



### install libs
# apt-get install -y conntrack ipvsadm ntp ipset jq iptables curl sysstat libseccomp
apt-get install -y conntrack ipvsadm ntp ipset jq iptables curl sysstat libseccomp2
#ipvs 依赖 ipset；
#ntp 保证各机器系统时间同步；



### close firewalld and clean iptables
sudo systemctl status firewalld
systemctl stop firewalld
systemctl disable firewalld
iptables -F && iptables -X && iptables -F -t nat && iptables -X -t nat
iptables -P FORWARD ACCEPT



# 关闭 swap 分区
# 如果开启了 swap 分区，kubelet 会启动失败(可以通过将参数 --fail-swap-on 设置为 false 来忽略 swap on)，故需要在每台机器上关闭 swap 分区。同时注释 /etc/fstab 中相应的条目，防止开机自动挂载 swap 分区：
swapon -s # 查
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab



# 关闭 SELinux
# 关闭 SELinux，否则后续 kubernetes 挂载目录时可能报错 Permission denied：
setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config




# 加载内核模块
modprobe ip_vs_rr
modprobe br_netfilter

# 优化内核参数
cat > kubernetes.conf <<EOF
net.bridge.bridge-nf-call-iptables=1
net.bridge.bridge-nf-call-ip6tables=1
net.ipv4.ip_forward=1
net.ipv4.tcp_tw_recycle=0
vm.swappiness=0 # 禁止使用 swap 空间，只有当系统 OOM 时才允许使用它
vm.overcommit_memory=1 # 不检查物理内存是否够用
vm.panic_on_oom=0 # 开启 OOM
fs.inotify.max_user_instances=8192
fs.inotify.max_user_watches=1048576
fs.file-max=52706963
fs.nr_open=52706963
net.ipv6.conf.all.disable_ipv6=1
net.netfilter.nf_conntrack_max=2310720
EOF
cp kubernetes.conf  /etc/sysctl.d/kubernetes.conf
sysctl -p /etc/sysctl.d/kubernetes.conf

# 必须关闭 tcp_tw_recycle，否则和 NAT 冲突，会导致服务不通；
# 关闭 IPV6，防止触发 docker BUG；


for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    scp /fff/kubernetes/bin/cfssl* ${node_ip}:/fff/kubernetes/bin/
done

# 更新 PATH 变量
# 将可执行文件目录添加到 PATH 环境变量中：
echo 'PATH=/fff/kubernetes/bin:$PATH' >>/root/.bashrc
source /root/.bashrc


### ca begin

cd /fff/kubernetes

cat > ca-config.json <<EOF
{
  "signing": {
    "default": {
      "expiry": "87600h"
    },
    "profiles": {
      "kubernetes": {
        "usages": [
            "signing",
            "key encipherment",
            "server auth",
            "client auth"
        ],
        "expiry": "87600h"
      }
    }
  }
}
EOF

cat > ca-csr.json <<EOF
{
  "CN": "kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "ST": "BeiJing",
      "L": "BeiJing",
      "O": "kubernetes",
      "OU": "google"
    }
  ]
}
EOF


cfssl gencert -initca ca-csr.json | cfssljson -bare ca


for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    ssh root@${node_ip} "mkdir -p /etc/kubernetes/cert"
    scp ca*.pem ca-config.json root@${node_ip}:/etc/kubernetes/cert
done


### ca end

## kubectl begin

cat > admin-csr.json <<EOF
{
  "CN": "admin",
  "hosts": [],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "ST": "BeiJing",
      "L": "BeiJing",
      "O": "system:masters",
      "OU": "google"
    }
  ]
}
EOF

cfssl gencert -ca=/fff/kubernetes/ca.pem \
  -ca-key=/fff/kubernetes/ca-key.pem \
  -config=/fff/kubernetes/ca-config.json \
  -profile=kubernetes admin-csr.json | cfssljson -bare admin


cfssl gencert -ca=/fff/kubernetes/ca.pem \
  -ca-key=/fff/kubernetes/ca-key.pem \
  -config=/fff/kubernetes/ca-config.json \
  -profile=kubernetes admin-csr.json | cfssljson -bare admin


# 设置集群参数
kubectl config set-cluster kubernetes \
  --certificate-authority=/fff/kubernetes/ca.pem \
  --embed-certs=true \
  --server=${KUBE_APISERVER} \
  --kubeconfig=kubectl.kubeconfig

# 设置客户端认证参数
kubectl config set-credentials admin \
  --client-certificate=/fff/kubernetes/admin.pem \
  --client-key=/fff/kubernetes/admin-key.pem \
  --embed-certs=true \
  --kubeconfig=kubectl.kubeconfig

# 设置上下文参数
kubectl config set-context kubernetes \
  --cluster=kubernetes \
  --user=admin \
  --kubeconfig=kubectl.kubeconfig

# 设置默认上下文
kubectl config use-context kubernetes --kubeconfig=kubectl.kubeconfig

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    ssh root@${node_ip} "mkdir -p ~/.kube"
    ssh root@${node_ip} "rm ~/.kube/config"
    scp kubectl.kubeconfig root@${node_ip}:~/.kube/config
done

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    ssh oudream@${node_ip} "mkdir -p ~/.kube"
    ssh oudream@${node_ip} "rm ~/.kube/config"
    scp kubectl.kubeconfig oudream@${node_ip}:~/.kube/config
done
## kubectl end.


## etcd begin:

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    scp -r /fff/etcd/etcd* root@${node_ip}:/fff/kubernetes/bin
    ssh root@${node_ip} "chmod +x /fff/kubernetes/bin/etcd*"
done


cat > etcd-csr.json <<EOF
{
  "CN": "etcd",
  "hosts": [
    "127.0.0.1",
    "${NODE_IPS[0]}",
    "${NODE_IPS[1]}",
    "${NODE_IPS[2]}"
  ],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "ST": "BeiJing",
      "L": "BeiJing",
      "O": "kubernetes",
      "OU": "google"
    }
  ]
}
EOF

cfssl gencert -ca=/fff/kubernetes/ca.pem \
    -ca-key=/fff/kubernetes/ca-key.pem \
    -config=/fff/kubernetes/ca-config.json \
    -profile=kubernetes etcd-csr.json | cfssljson -bare etcd


for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
# del del del
    ssh root@${node_ip} "rm -r /etc/etcd/cert"
    ssh root@${node_ip} "mkdir -p /etc/etcd/cert"
    scp etcd*.pem root@${node_ip}:/etc/etcd/cert/
done


cat > etcd.service.template <<EOF
[Unit]
Description=Etcd Server
After=network.target
After=network-online.target
Wants=network-online.target
Documentation=https://github.com/coreos

[Service]
Type=notify
WorkingDirectory=${ETCD_DATA_DIR}
ExecStart=/fff/kubernetes/bin/etcd \\
  --data-dir=${ETCD_DATA_DIR} \\
  --wal-dir=${ETCD_WAL_DIR} \\
  --name=##NODE_NAME## \\
  --cert-file=/etc/etcd/cert/etcd.pem \\
  --key-file=/etc/etcd/cert/etcd-key.pem \\
  --trusted-ca-file=/etc/kubernetes/cert/ca.pem \\
  --peer-cert-file=/etc/etcd/cert/etcd.pem \\
  --peer-key-file=/etc/etcd/cert/etcd-key.pem \\
  --peer-trusted-ca-file=/etc/kubernetes/cert/ca.pem \\
  --peer-client-cert-auth \\
  --client-cert-auth \\
  --listen-peer-urls=https://##NODE_IP##:2380 \\
  --initial-advertise-peer-urls=https://##NODE_IP##:2380 \\
  --listen-client-urls=https://##NODE_IP##:2379,http://127.0.0.1:2379 \\
  --advertise-client-urls=https://##NODE_IP##:2379 \\
  --initial-cluster-token=etcd-cluster-0 \\
  --initial-cluster=${ETCD_NODES} \\
  --initial-cluster-state=new \\
  --auto-compaction-mode=periodic \\
  --auto-compaction-retention=1 \\
  --max-request-bytes=33554432 \\
  --quota-backend-bytes=6442450944 \\
  --heartbeat-interval=250 \\
  --election-timeout=2000
Restart=on-failure
RestartSec=5
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

for (( i=0; i < 3; i++ ))
do
    sed -e "s/##NODE_NAME##/${NODE_NAMES[i]}/" -e "s/##NODE_IP##/${NODE_IPS[i]}/" etcd.service.template > etcd-${NODE_IPS[i]}.service
done

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    scp etcd-${node_ip}.service root@${node_ip}:/etc/systemd/system/etcd.service
done

# del del del
for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    ssh root@${node_ip} "systemctl stop etcd && systemctl disable etcd && systemctl daemon-reload" &
    ssh root@${node_ip} "rm /etc/systemd/system/etcd.service" &
done

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
#    ssh root@${node_ip} "rm -r ${ETCD_DATA_DIR} ${ETCD_WAL_DIR}"
#    ssh root@${node_ip} "mkdir -p ${ETCD_DATA_DIR} ${ETCD_WAL_DIR}"
    ssh root@${node_ip} "systemctl daemon-reload && systemctl enable etcd && systemctl restart etcd " &
done

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    ETCDCTL_API=3 /fff/kubernetes/bin/etcdctl \
    --endpoints=https://${node_ip}:2379 \
    --cacert=/etc/kubernetes/cert/ca.pem \
    --cert=/etc/etcd/cert/etcd.pem \
    --key=/etc/etcd/cert/etcd-key.pem endpoint health
done

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    ETCDCTL_API=2 /fff/kubernetes/bin/etcdctl \
    --endpoints=https://${node_ip}:2379 \
    --ca-file=/etc/kubernetes/cert/ca.pem \
    --cert-file=/etc/etcd/cert/etcd.pem \
    --key-file=/etc/etcd/cert/etcd-key.pem cluster-health
done

### error : context deadline exceeded

    ### v2
    export ETCDCTL_CA_FILE=/etc/kubernetes/cert/ca.pem
    export ETCDCTL_CERT_FILE=/etc/etcd/cert/etcd.pem
    export ETCDCTL_KEY_FILE=/etc/etcd/cert/etcd-key.pem
    export ETCDCTL_ENDPOINTS=${ETCD_ENDPOINTS}

    ETCDCTL_API=2 /fff/kubernetes/bin/etcdctl \
    --debug \
    --ca-file=/etc/kubernetes/cert/ca.pem \
    --cert-file=/etc/etcd/cert/etcd.pem \
    --key-file=/etc/etcd/cert/etcd-key.pem \
    --endpoints=${ETCD_ENDPOINTS} \

    exec-watch --recursive /foo -- sh -c "env | grep ETCD"

    get foo

    cluster-health


    ### v3
    export ETCDCTL_DIAL_TIMEOUT=3s
    export ETCDCTL_CACERT=/etc/kubernetes/cert/ca.pem
    export ETCDCTL_CERT=/etc/etcd/cert/etcd.pem
    export ETCDCTL_KEY=/etc/etcd/cert/etcd-key.pem

    ETCDCTL_API=3 /fff/kubernetes/bin/etcdctl \
    --cacert=/etc/kubernetes/cert/ca.pem \
    --cert=/etc/etcd/cert/etcd.pem \
    --key=/etc/etcd/cert/etcd-key.pem \
    --endpoints=${ETCD_ENDPOINTS} \

    endpoint health

    -w table endpoint status

    put foo bar

    get foo

-w
table
--cacert=/etc/kubernetes/cert/ca.pem
--cert=/etc/etcd/cert/etcd.pem
--key=/etc/etcd/cert/etcd-key.pem
--endpoints=https://10.31.58.132:2379,https://10.31.58.75:2379,https://10.31.58.19:2379
endpoint
status


--data-dir=/eee/kubernetes/etcd/data 
--wal-dir=/eee/kubernetes/etcd/wal 
--name=ics-ubuntu2 
--cert-file=/etc/etcd/cert/etcd.pem 
--key-file=/etc/etcd/cert/etcd-key.pem 
--trusted-ca-file=/etc/kubernetes/cert/ca.pem 
--peer-cert-file=/etc/etcd/cert/etcd.pem 
--peer-key-file=/etc/etcd/cert/etcd-key.pem 
--peer-trusted-ca-file=/etc/kubernetes/cert/ca.pem 
--peer-client-cert-auth 
--client-cert-auth 
--listen-peer-urls=https://10.31.58.132:2380 
--initial-advertise-peer-urls=https://10.31.58.132:2380 
--listen-client-urls=https://10.31.58.132:2379,http://127.0.0.1:2379 
--advertise-client-urls=https://10.31.58.132:2379 
--initial-cluster-token=etcd-cluster-0 
--initial-cluster=ics-ubuntu2=https://10.31.58.132:2380,ics-ubuntu3=https://10.31.58.75:2380,ics-ubuntu1=https://10.31.58.19:2380 
--initial-cluster-state=new 
--auto-compaction-mode=periodic 
--auto-compaction-retention=1 
--max-request-bytes=33554432 
--quota-backend-bytes=6442450944 
--heartbeat-interval=250 
--election-timeout=2000


export http_proxy=
export HTTP_PROXY=
export https_proxy=
export HTTPS_PROXY=
export ftp_proxy=
export FTP_PROXY=
export all_proxy=
export ALL_PROXY=
export no_proxy=127.0.0.1,localhost,192.168.0.*,192.168.1.*,192.168.99.*,10.31.58.*,10.32.50.*,10.31.16.*,10.30.0.*,hadoop-master,hadoop-slave1,hadoop-slave2
export NO_PROXY=$no_proxy

## etcd end.





## flannel begin:

wget https://github.com/coreos/flannel/releases/download/v0.11.0/flannel-v0.11.0-linux-amd64.tar.gz
tar -xzvf flannel-v0.11.0-linux-amd64.tar.gz

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    scp ./{flanneld,mk-docker-opts.sh} root@${node_ip}:/fff/kubernetes/bin/
done


cat > flanneld-csr.json <<EOF
{
  "CN": "flanneld",
  "hosts": [],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "ST": "BeiJing",
      "L": "BeiJing",
      "O": "kubernetes",
      "OU": "google"
    }
  ]
}
EOF

cfssl gencert -ca=/fff/kubernetes/ca.pem \
  -ca-key=/fff/kubernetes/ca-key.pem \
  -config=/fff/kubernetes/ca-config.json \
  -profile=kubernetes flanneld-csr.json | cfssljson -bare flanneld


for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    ssh root@${node_ip} "mkdir -p /etc/flanneld/cert"
    scp flanneld*.pem root@${node_ip}:/etc/flanneld/cert
done




ETCDCTL_API=2 /fff/kubernetes/bin/etcdctl \
  --ca-file=/etc/kubernetes/cert/ca.pem \
  --cert-file=/etc/etcd/cert/etcd.pem \
  --key-file=/etc/etcd/cert/etcd-key.pem \
  --endpoints=${ETCD_ENDPOINTS} \
  cluster-health

ETCDCTL_API=2 /fff/kubernetes/bin/etcdctl \
  --ca-file=/etc/kubernetes/cert/ca.pem \
  --cert-file=/etc/etcd/cert/etcd.pem \
  --key-file=/etc/etcd/cert/etcd-key.pem \
  --endpoint=${ETCD_ENDPOINTS} \
  mk ${FLANNEL_ETCD_PREFIX}/config '{"Network":"'${CLUSTER_CIDR}'", "SubnetLen": 21, "Backend": {"Type": "vxlan"}}'

ETCDCTL_API=2 /fff/kubernetes/bin/etcdctl \
  --ca-file=/etc/kubernetes/cert/ca.pem \
  --cert-file=/fff/kubernetes/flanneld.pem \
  --key-file=/fff/kubernetes/flanneld-key.pem \
  --endpoint=${ETCD_ENDPOINTS} \
  get ${FLANNEL_ETCD_PREFIX}/config



cat > flanneld.service << EOF
[Unit]
Description=Flanneld overlay address etcd agent
After=network.target
After=network-online.target
Wants=network-online.target
After=etcd.service
Before=docker.service

[Service]
Type=notify
ExecStart=/fff/kubernetes/bin/flanneld \\
  -etcd-cafile=/etc/kubernetes/cert/ca.pem \\
  -etcd-certfile=/etc/flanneld/cert/flanneld.pem \\
  -etcd-keyfile=/etc/flanneld/cert/flanneld-key.pem \\
  -etcd-endpoints=${ETCD_ENDPOINTS} \\
  -etcd-prefix=${FLANNEL_ETCD_PREFIX} \\
  -iface=${IFACE} \\
  -ip-masq
ExecStartPost=/fff/kubernetes/bin/mk-docker-opts.sh -k DOCKER_NETWORK_OPTIONS -d /run/flannel/docker
Restart=always
RestartSec=5
StartLimitInterval=0

[Install]
WantedBy=multi-user.target
RequiredBy=docker.service
EOF

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    scp flanneld.service root@${node_ip}:/etc/systemd/system/
done

scp flanneld.service root@${NODE_IPS[1]}:/etc/systemd/system/

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    ssh root@${node_ip} "systemctl daemon-reload && systemctl enable flanneld && systemctl restart flanneld"
done

# del del del
for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    ssh root@${node_ip} "systemctl stop flanneld && systemctl disable flanneld && systemctl daemon-reload" &
    ssh root@${node_ip} "rm /etc/systemd/system/flanneld.service" &
done

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    ssh root@${node_ip} "systemctl status flanneld|grep Active"
done

etcdctl \
  --endpoints=${ETCD_ENDPOINTS} \
  --ca-file=/etc/kubernetes/cert/ca.pem \
  --cert-file=/etc/flanneld/cert/flanneld.pem \
  --key-file=/etc/flanneld/cert/flanneld-key.pem \
  get ${FLANNEL_ETCD_PREFIX}/config

etcdctl \
  --endpoints=${ETCD_ENDPOINTS} \
  --ca-file=/etc/kubernetes/cert/ca.pem \
  --cert-file=/etc/flanneld/cert/flanneld.pem \
  --key-file=/etc/flanneld/cert/flanneld-key.pem \
  ls ${FLANNEL_ETCD_PREFIX}/subnets

etcdctl \
  --endpoints=${ETCD_ENDPOINTS} \
  --ca-file=/etc/kubernetes/cert/ca.pem \
  --cert-file=/etc/flanneld/cert/flanneld.pem \
  --key-file=/etc/flanneld/cert/flanneld-key.pem \
  get ${FLANNEL_ETCD_PREFIX}/subnets/172.30.48.0-21

  get ${FLANNEL_ETCD_PREFIX}/subnets/172.30.40.0-21

  get ${FLANNEL_ETCD_PREFIX}/subnets/172.30.168.0-21

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    ssh ${node_ip} "ip addr show flannel.1|grep -w inet"
done

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    ssh ${node_ip} "ping -c 1 172.30.40.0"
    ssh ${node_ip} "ping -c 1 172.30.168.0"
    ssh ${node_ip} "ping -c 1 172.30.48.0"
done

## flannel end.



### nginx begin:
cd /fff
wget http://nginx.org/download/nginx-1.15.3.tar.gz
tar -xzvf nginx-1.15.3.tar.gz

cd /fff/nginx-1.15.3
mkdir nginx-prefix
./configure --with-stream --without-http --prefix=$(pwd)/nginx-prefix --without-http_uwsgi_module --without-http_scgi_module --without-http_fastcgi_module
make && make install

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    mkdir -p /fff/kubernetes/kube-nginx/{conf,logs,sbin}
done

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    scp /fff/nginx-1.15.3/nginx-prefix/sbin/nginx  root@${node_ip}:/fff/kubernetes/kube-nginx/sbin/kube-nginx
    ssh root@${node_ip} "chmod a+x /fff/kubernetes/kube-nginx/sbin/*"
    ssh root@${node_ip} "mkdir -p /fff/kubernetes/kube-nginx/{conf,logs,sbin}"
done

cat > kube-nginx.conf <<EOF
worker_processes 1;

events {
    worker_connections  1024;
}

stream {
    upstream backend {
        hash $remote_addr consistent;
        server ${NODE_IPS[0]}:6443        max_fails=3 fail_timeout=30s;
        server ${NODE_IPS[1]}:6443        max_fails=3 fail_timeout=30s;
        server ${NODE_IPS[2]}:6443        max_fails=3 fail_timeout=30s;
    }

    server {
        listen 127.0.0.1:8443;
        proxy_connect_timeout 1s;
        proxy_pass backend;
    }
}
EOF

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    scp kube-nginx.conf  root@${node_ip}:/fff/kubernetes/kube-nginx/conf/kube-nginx.conf
done

cat > kube-nginx.service <<EOF
[Unit]
Description=kube-apiserver nginx proxy
After=network.target
After=network-online.target
Wants=network-online.target

[Service]
Type=forking
ExecStartPre=/fff/kubernetes/kube-nginx/sbin/kube-nginx -c /fff/kubernetes/kube-nginx/conf/kube-nginx.conf -p /fff/kubernetes/kube-nginx -t
ExecStart=/fff/kubernetes/kube-nginx/sbin/kube-nginx -c /fff/kubernetes/kube-nginx/conf/kube-nginx.conf -p /fff/kubernetes/kube-nginx
ExecReload=/fff/kubernetes/kube-nginx/sbin/kube-nginx -c /fff/kubernetes/kube-nginx/conf/kube-nginx.conf -p /fff/kubernetes/kube-nginx -s reload
PrivateTmp=true
Restart=always
RestartSec=5
StartLimitInterval=0
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    scp kube-nginx.service  root@${node_ip}:/etc/systemd/system/
done

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    ssh root@${node_ip} "systemctl daemon-reload && systemctl enable kube-nginx && systemctl restart kube-nginx"
done

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    ssh root@${node_ip} "systemctl status kube-nginx |grep 'Active:'"
done
### nginx end.




for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    ssh root@${node_ip} "chown -R oudream /etc/etcd ; chgrp -R oudream /etc/etcd" &
    ssh root@${node_ip} "chown -R oudream /etc/kubernetes ; chgrp -R oudream /etc/kubernetes" &
    ssh root@${node_ip} "chown -R oudream /etc/flanneld ; chgrp -R oudream /etc/flanneld" &
    ssh root@${node_ip} "chown -R oudream /fff/kubernetes ; chgrp -R oudream /fff/kubernetes" &
done



### apiserver

cat > kubernetes-csr.json <<EOF
{
  "CN": "kubernetes",
  "hosts": [
    "127.0.0.1",
    "${NODE_IPS[0]}",
    "${NODE_IPS[1]}",
    "${NODE_IPS[2]}",
    "${CLUSTER_KUBERNETES_SVC_IP}",
    "kubernetes",
    "kubernetes.default",
    "kubernetes.default.svc",
    "kubernetes.default.svc.cluster",
    "kubernetes.default.svc.cluster.local."
  ],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "ST": "BeiJing",
      "L": "BeiJing",
      "O": "kubernetes",
      "OU": "google"
    }
  ]
}
EOF

cfssl gencert -ca=/fff/kubernetes/ca.pem \
  -ca-key=/fff/kubernetes/ca-key.pem \
  -config=/fff/kubernetes/ca-config.json \
  -profile=kubernetes kubernetes-csr.json | cfssljson -bare kubernetes

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    ssh root@${node_ip} "mkdir -p /etc/kubernetes/cert"
    ssh root@${node_ip} "rm /etc/kubernetes/cert/kubernetes*.pem"
    scp kubernetes*.pem root@${node_ip}:/etc/kubernetes/cert/
done

cat > encryption-config.yaml <<EOF
kind: EncryptionConfig
apiVersion: v1
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: ${ENCRYPTION_KEY}
      - identity: {}
EOF

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    scp encryption-config.yaml root@${node_ip}:/etc/kubernetes/
done

cat > audit-policy.yaml <<EOF
apiVersion: audit.k8s.io/v1beta1
kind: Policy
rules:
  # The following requests were manually identified as high-volume and low-risk, so drop them.
  - level: None
    resources:
      - group: ""
        resources:
          - endpoints
          - services
          - services/status
    users:
      - 'system:kube-proxy'
    verbs:
      - watch

  - level: None
    resources:
      - group: ""
        resources:
          - nodes
          - nodes/status
    userGroups:
      - 'system:nodes'
    verbs:
      - get

  - level: None
    namespaces:
      - kube-system
    resources:
      - group: ""
        resources:
          - endpoints
    users:
      - 'system:kube-controller-manager'
      - 'system:kube-scheduler'
      - 'system:serviceaccount:kube-system:endpoint-controller'
    verbs:
      - get
      - update

  - level: None
    resources:
      - group: ""
        resources:
          - namespaces
          - namespaces/status
          - namespaces/finalize
    users:
      - 'system:apiserver'
    verbs:
      - get

  # Don't log HPA fetching metrics.
  - level: None
    resources:
      - group: metrics.k8s.io
    users:
      - 'system:kube-controller-manager'
    verbs:
      - get
      - list

  # Don't log these read-only URLs.
  - level: None
    nonResourceURLs:
      - '/healthz*'
      - /version
      - '/swagger*'

  # Don't log events requests.
  - level: None
    resources:
      - group: ""
        resources:
          - events

  # node and pod status calls from nodes are high-volume and can be large, don't log responses for expected updates from nodes
  - level: Request
    omitStages:
      - RequestReceived
    resources:
      - group: ""
        resources:
          - nodes/status
          - pods/status
    users:
      - kubelet
      - 'system:node-problem-detector'
      - 'system:serviceaccount:kube-system:node-problem-detector'
    verbs:
      - update
      - patch

  - level: Request
    omitStages:
      - RequestReceived
    resources:
      - group: ""
        resources:
          - nodes/status
          - pods/status
    userGroups:
      - 'system:nodes'
    verbs:
      - update
      - patch

  # deletecollection calls can be large, don't log responses for expected namespace deletions
  - level: Request
    omitStages:
      - RequestReceived
    users:
      - 'system:serviceaccount:kube-system:namespace-controller'
    verbs:
      - deletecollection

  # Secrets, ConfigMaps, and TokenReviews can contain sensitive & binary data,
  # so only log at the Metadata level.
  - level: Metadata
    omitStages:
      - RequestReceived
    resources:
      - group: ""
        resources:
          - secrets
          - configmaps
      - group: authentication.k8s.io
        resources:
          - tokenreviews
  # Get repsonses can be large; skip them.
  - level: Request
    omitStages:
      - RequestReceived
    resources:
      - group: ""
      - group: admissionregistration.k8s.io
      - group: apiextensions.k8s.io
      - group: apiregistration.k8s.io
      - group: apps
      - group: authentication.k8s.io
      - group: authorization.k8s.io
      - group: autoscaling
      - group: batch
      - group: certificates.k8s.io
      - group: extensions
      - group: metrics.k8s.io
      - group: networking.k8s.io
      - group: policy
      - group: rbac.authorization.k8s.io
      - group: scheduling.k8s.io
      - group: settings.k8s.io
      - group: storage.k8s.io
    verbs:
      - get
      - list
      - watch

  # Default level for known APIs
  - level: RequestResponse
    omitStages:
      - RequestReceived
    resources:
      - group: ""
      - group: admissionregistration.k8s.io
      - group: apiextensions.k8s.io
      - group: apiregistration.k8s.io
      - group: apps
      - group: authentication.k8s.io
      - group: authorization.k8s.io
      - group: autoscaling
      - group: batch
      - group: certificates.k8s.io
      - group: extensions
      - group: metrics.k8s.io
      - group: networking.k8s.io
      - group: policy
      - group: rbac.authorization.k8s.io
      - group: scheduling.k8s.io
      - group: settings.k8s.io
      - group: storage.k8s.io

  # Default level for all other requests.
  - level: Metadata
    omitStages:
      - RequestReceived
EOF

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    scp audit-policy.yaml root@${node_ip}:/etc/kubernetes/audit-policy.yaml
done

cat > proxy-client-csr.json <<EOF
{
  "CN": "aggregator",
  "hosts": [],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "ST": "BeiJing",
      "L": "BeiJing",
      "O": "kubernetes",
      "OU": "google"
    }
  ]
}
EOF

cfssl gencert -ca=/etc/kubernetes/cert/ca.pem \
  -ca-key=/etc/kubernetes/cert/ca-key.pem  \
  -config=/etc/kubernetes/cert/ca-config.json  \
  -profile=kubernetes proxy-client-csr.json | cfssljson -bare proxy-client

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    scp proxy-client*.pem root@${node_ip}:/etc/kubernetes/cert/
done

scp /fff/kubernetes/bin/{apiextensions-apiserver,cloud-controller-manager,kube-apiserver,kube-controller-manager,kube-scheduler,mounter} root@${NODE_IPS[1]}:/fff/kubernetes/bin/
ssh root@${NODE_IPS[1]} "chmod +x /fff/kubernetes/bin/*"
scp /fff/kubernetes/bin/{apiextensions-apiserver,cloud-controller-manager,kube-apiserver,kube-controller-manager,kube-scheduler,mounter} root@${NODE_IPS[2]}:/fff/kubernetes/bin/
ssh root@${NODE_IPS[2]} "chmod +x /fff/kubernetes/bin/*"

cat > kube-apiserver.service.template <<EOF
[Unit]
Description=Kubernetes API Server
Documentation=https://github.com/GoogleCloudPlatform/kubernetes
After=network.target

[Service]
WorkingDirectory=${K8S_DIR}/kube-apiserver
ExecStart=/fff/kubernetes/bin/kube-apiserver \\
  --advertise-address=##NODE_IP## \\
  --default-not-ready-toleration-seconds=360 \\
  --default-unreachable-toleration-seconds=360 \\
  --feature-gates=DynamicAuditing=true \\
  --max-mutating-requests-inflight=2000 \\
  --max-requests-inflight=4000 \\
  --default-watch-cache-size=200 \\
  --delete-collection-workers=2 \\
  --encryption-provider-config=/etc/kubernetes/encryption-config.yaml \\
  --etcd-cafile=/etc/kubernetes/cert/ca.pem \\
  --etcd-certfile=/etc/kubernetes/cert/kubernetes.pem \\
  --etcd-keyfile=/etc/kubernetes/cert/kubernetes-key.pem \\
  --etcd-servers=${ETCD_ENDPOINTS} \\
  --bind-address=##NODE_IP## \\
  --secure-port=6443 \\
  --tls-cert-file=/etc/kubernetes/cert/kubernetes.pem \\
  --tls-private-key-file=/etc/kubernetes/cert/kubernetes-key.pem \\
  --insecure-port=0 \\
  --audit-dynamic-configuration \\
  --audit-log-maxage=15 \\
  --audit-log-maxbackup=3 \\
  --audit-log-maxsize=100 \\
  --audit-log-mode=batch \\
  --audit-log-truncate-enabled \\
  --audit-log-batch-buffer-size=20000 \\
  --audit-log-batch-max-size=2 \\
  --audit-log-path=${K8S_DIR}/kube-apiserver/audit.log \\
  --audit-policy-file=/etc/kubernetes/audit-policy.yaml \\
  --profiling \\
  --anonymous-auth=false \\
  --client-ca-file=/etc/kubernetes/cert/ca.pem \\
  --enable-bootstrap-token-auth \\
  --requestheader-allowed-names="" \\
  --requestheader-client-ca-file=/etc/kubernetes/cert/ca.pem \\
  --requestheader-extra-headers-prefix="X-Remote-Extra-" \\
  --requestheader-group-headers=X-Remote-Group \\
  --requestheader-username-headers=X-Remote-User \\
  --service-account-key-file=/etc/kubernetes/cert/ca.pem \\
  --authorization-mode=Node,RBAC \\
  --runtime-config=api/all=true \\
  --enable-admission-plugins=NodeRestriction \\
  --allow-privileged=true \\
  --apiserver-count=3 \\
  --event-ttl=168h \\
  --kubelet-certificate-authority=/etc/kubernetes/cert/ca.pem \\
  --kubelet-client-certificate=/etc/kubernetes/cert/kubernetes.pem \\
  --kubelet-client-key=/etc/kubernetes/cert/kubernetes-key.pem \\
  --kubelet-https=true \\
  --kubelet-timeout=10s \\
  --proxy-client-cert-file=/etc/kubernetes/cert/proxy-client.pem \\
  --proxy-client-key-file=/etc/kubernetes/cert/proxy-client-key.pem \\
  --service-cluster-ip-range=${SERVICE_CIDR} \\
  --service-node-port-range=${NODE_PORT_RANGE} \\
  --logtostderr=true \\
  --v=2
Restart=on-failure
RestartSec=10
Type=notify
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

for (( i=0; i < 3; i++ ))
do
    sed -e "s/##NODE_NAME##/${NODE_NAMES[i]}/" -e "s/##NODE_IP##/${NODE_IPS[i]}/" kube-apiserver.service.template > kube-apiserver-${NODE_IPS[i]}.service
done

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    scp kube-apiserver-${node_ip}.service root@${node_ip}:/etc/systemd/system/kube-apiserver.service
done

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    ssh root@${node_ip} "mkdir -p ${K8S_DIR}/kube-apiserver"
    ssh root@${node_ip} "systemctl daemon-reload && systemctl enable kube-apiserver && systemctl restart kube-apiserver"
done

for node_ip in ${NODE_IPS[@]}
do
    echo ">>> ${node_ip}"
    ssh root@${node_ip} "systemctl status kube-apiserver |grep 'Active:'"
done

ETCDCTL_API=3 etcdctl \
    --endpoints=${ETCD_ENDPOINTS} \
    --cacert=/fff/kubernetes/ca.pem \
    --cert=/fff/kubernetes/etcd.pem \
    --key=/fff/kubernetes/etcd-key.pem \
    get /registry/ --prefix --keys-only


#检查集群信息
kubectl cluster-info
# Kubernetes master is running at https://127.0.0.1:8443
# To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.

kubectl get all --all-namespaces
# NAMESPACE   NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
# default     service/kubernetes   ClusterIP   10.254.0.1   <none>        443/TCP   12m

kubectl get componentstatuses
# NAME                 STATUS      MESSAGE                                                                                     ERROR
# scheduler            Unhealthy   Get http://127.0.0.1:10251/healthz: dial tcp 127.0.0.1:10251: connect: connection refused
# controller-manager   Unhealthy   Get http://127.0.0.1:10252/healthz: dial tcp 127.0.0.1:10252: connect: connection refused
# etcd-0               Healthy     {"health":"true"}
# etcd-1               Healthy     {"health":"true"}
# etcd-2               Healthy     {"health":"true"}

# 授予 kube-apiserver 访问 kubelet API 的权限
# 在执行 kubectl exec、run、logs 等命令时，apiserver 会将请求转发到 kubelet 的 https 端口。
#    这里定义 RBAC 规则，授权 apiserver 使用的证书（kubernetes.pem）用户名（CN：kuberntes）
#    访问 kubelet API 的权限：
kubectl create clusterrolebinding kube-apiserver:kubelet-apis --clusterrole=system:kubelet-api-admin --user kubernetes
# clusterrolebinding.rbac.authorization.k8s.io/kube-apiserver:kubelet-apis created

