# 使用Ansible安装二进制Kubernetes集群

# 一、Prerequisite

|          | ansible部署节点              |                                 | Master 1                                                     | Master 2                                                     | Master 3                                                     | Node1                       |
| -------- | ---------------------------- | ------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | --------------------------- |
| 物理配置 | 1C2G                         | 4C8G100G                        | 2C4G80G                                                      | 2C4G80G                                                      | 2C4G80G                                                      | 8C32G100G                   |
| 集群组件 | ansible、<br>eas             | NFS Server、Ceph、Harbor、Nginx | etcd1、kube-apiserver、kube-controller-manager、kube-scheduler<br/>docker、kubelet、kube-proxy | etcd1、kube-apiserver、kube-controller-manager、kube-scheduler<br/>docker、kubelet、kube-proxy | etcd1、kube-apiserver、kube-controller-manager、kube-scheduler<br/>docker、kubelet、kube-proxy | docker、kubelet、kube-proxy |
| IP地址   | 192.168.1.80                 | 192.168.1.110                   | 192.168.1.111                                                | 192.168.1.112                                                | 192.168.1.113                                                | 192.168.1.121               |
| 主机名   | ansible.k8s116.curiouser.com | tools.k8s116.curiouser.com      | master1.k8s116.curiouser.com                                 | master2.k8s116.curiouser.com                                 | master3.k8s116.curiouser.com                                 | node1.k8s116.curiouser.com  |

# 二、ansible脚本简介



```bash
├── 01.prepare.yml
├── 02.etcd.yml
├── 03.containerd.yml
├── 03.docker.yml
├── 04.kube-master.yml
├── 05.kube-node.yml
├── 06.network.yml
├── 07.cluster-addon.yml
├── 11.harbor.yml
├── 22.upgrade.yml
├── 23.backup.yml
├── 24.restore.yml
├── 90.setup.yml
├── 91.start.yml
├── 92.stop.yml
├── 99.clean.yml
├── ansible.cfg
├── bin
│   ├── bridge
│   ├── calicoctl
│   ├── cfssl
│   ├── cfssl-certinfo
│   ├── cfssljson
│   ├── containerd
│   ├── containerd-bin
│   ├── containerd-shim
│   ├── ctr
│   ├── docker
│   ├── docker-compose
│   ├── dockerd
│   ├── docker-init
│   ├── docker-proxy
│   ├── etcd
│   ├── etcdctl
│   ├── flannel
│   ├── helm
│   ├── host-local
│   ├── kube-apiserver
│   ├── kube-controller-manager
│   ├── kubectl
│   ├── kubelet
│   ├── kube-proxy
│   ├── kube-scheduler
│   ├── loopback
│   ├── portmap
│   ├── readme.md
│   ├── runc
│   └── tuning
├── dockerfiles
│   └── readme.md
├── docs
│   ├── guide
│   ├── mixes
│   ├── op
│   ├── practice
│   ├── release-notes
│   └── setup
├── down
│   ├── calico_v3.4.4.tar
│   ├── ca.pem
│   ├── coredns_1.6.2.tar
│   ├── dashboard_v2.0.0-beta5.tar
│   ├── docker-18.09.9.tgz
│   ├── download.sh
│   ├── flannel_v0.11.0-amd64.tar
│   ├── harbor
│   ├── harbor-offline-installer-v1.9.4.tgz
│   ├── kubeasz_2.1.0.tar
│   ├── metrics-scraper_v1.0.1.tar
│   ├── metrics-server_v0.3.6.tar
│   ├── packages
│   ├── pause_3.1.tar
│   └── traefik_v1.7.12.tar
├── example
│   ├── hosts.allinone
│   └── hosts.multi-node
├── hosts
├── manifests
│   ├── dashboard
│   ├── efk
│   ├── es-cluster
│   ├── heapster
│   ├── ingress
│   ├── jenkins
│   ├── mariadb-cluster
│   ├── metrics-server
│   ├── mysql-cluster
│   ├── prometheus
│   ├── redis-cluster
│   └── storage
├── pics
│   ├── alipay.gif
│   ├── allow_from_external.gif
│   ├── cilium_http_gsg.jpg
│   ├── cilium_http_l3_l4_gsg.jpg
│   ├── cilium_http_l3_l4_l7_gsg.jpg
│   ├── deny_from_other_namespaces.gif
│   ├── grafana.png
│   ├── ha-1x.gif
│   ├── ha-2x.gif
│   ├── influxdb.png
│   ├── kubeasz.svg
│   ├── logo_kubeasz.png
│   └── wxpay.gif
├── README.md
├── roles
│   ├── calico
│   ├── chrony
│   ├── cilium
│   ├── clean
│   ├── cluster-addon
│   ├── cluster-restore
│   ├── cluster-storage
│   ├── containerd
│   ├── deploy
│   ├── docker
│   ├── etcd
│   ├── ex-lb
│   ├── flannel
│   ├── harbor
│   ├── helm
│   ├── kube-master
│   ├── kube-node
│   ├── kube-ovn
│   ├── kube-router
│   ├── os-harden
│   └── prepare
├── tls.crt
├── tls.key
└── tools
    ├── 01.addetcd.yml			# 添加etcd节点的
    ├── 02.addnode.yml
    ├── 03.addmaster.yml
    ├── 11.deletcd.yml
    ├── 12.delnode.yml
    ├── 13.delmaster.yml
    ├── basic-env-setup.sh
    ├── change_ip_aio.yml
    ├── change_k8s_network.yml
    ├── easzctl
    ├── easzup
    ├── imgutils
    └── yc-ssh-key-copy.sh
```



# 三、Operation

## 0.在部署节点/etc/hosts中配置规划好的主机名与IP地址的域名映射关系

## 1.ansible节点安装ansible

```bash
pip install ansible==2.6.18 netaddr==0.7.19 -i https://mirrors.aliyun.com/pypi/simple/
```

## 2.ansible节配置k8s节点主机名及IP与主机名的域名映射关系

### ① 下载ansible脚本	

    ```bash
wget https://github.com/RationalMonster/ansible-playbook/archive/master.zip && \
unzip master.zip && \
mv ansible-playbook-master ansible-playbook-sethostname-installdocker && \
cd ansible-playbook-sethostname-installdocker
    ```

### ② 配置inventry

```
[k8s:children]
masters
nodes
[k8s:vars]
ansible_ssh_pass="****"
[masters]
192.168.1.111 hostname=master1.k8s116.curiouser.com
192.168.1.112 hostname=master2.k8s116.curiouser.com
192.168.1.113 hostname=master3.k8s116.curiouser.com
[nodes]
192.168.1.121 hostname=node1.k8s116.curiouser.com
```

### ③执行ansible脚本

```bash
ansible-playbook -i inventory playbook/sethostname.yml -k --ask-vault-pass
```

### ④重启k8s集群所有节点使主机名生效

## 3.下载kubeasz中的安装准备工具脚本easzup

```bash
export easzup_version=2.1.0 && \
curl -fLO https://github.com/easzlab/kubeasz/releases/download/${easzup_version}/easzup && \
chmod +x easzup && \
./easzup -D
```

## 4.(可选)修改ansible脚本中kubelet的service 服务模板配置文件

/etc/ansible/roles/kube-node/templates/kubelet.service.j2

```ini
[Unit]
Description=Kubernetes Kubelet
Documentation=https://github.com/GoogleCloudPlatform/kubernetes
[Service]
WorkingDirectory=/var/lib/kubelet
{% if KUBE_RESERVED_ENABLED == "yes" or SYS_RESERVED_ENABLED == "yes" %}
ExecStartPre=/bin/mount -o remount,rw '/sys/fs/cgroup'
ExecStartPre=/bin/mkdir -p /sys/fs/cgroup/cpuset/system.slice/kubelet.service
ExecStartPre=/bin/mkdir -p /sys/fs/cgroup/hugetlb/system.slice/kubelet.service
ExecStartPre=/bin/mkdir -p /sys/fs/cgroup/memory/system.slice/kubelet.service
ExecStartPre=/bin/mkdir -p /sys/fs/cgroup/pids/system.slice/kubelet.service
{% endif %}
ExecStart={{ bin_dir }}/kubelet \
  --config=/var/lib/kubelet/config.yaml \
{% if KUBE_VER|float < 1.13 %}
  --allow-privileged=true \
{% endif %}
  --cni-bin-dir={{ bin_dir }} \
  --cni-conf-dir=/etc/cni/net.d \
{% if CONTAINER_RUNTIME == "containerd" %}
  --container-runtime=remote \
  --container-runtime-endpoint=unix:///run/containerd/containerd.sock \
{% endif %}
  # =====修改处========
  --hostname-override={{ ansible_nodename }} \											
  --kubeconfig=/etc/kubernetes/kubelet.kubeconfig \
  --network-plugin=cni \
  --pod-infra-container-image={{ SANDBOX_IMAGE }} \
  --root-dir={{ KUBELET_ROOT_DIR }} \
  --v=2
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
```
## 5.配置k8s集群参数的主机清单

```bash
cp /etc/ansible/example/hosts.multi-node /etc/ansible/hosts
```

```
# 'etcd' cluster should have odd member(s) (1,3,5,...)
# variable 'NODE_NAME' is the distinct name of a member in 'etcd' cluster
[etcd]
192.168.1.111 NODE_NAME=etcd1
192.168.1.112 NODE_NAME=etcd2
192.168.1.113 NODE_NAME=etcd3

# master node(s)
[kube-master]
192.168.1.111
192.168.1.112
192.168.1.113

# work node(s)
[kube-node]
192.168.1.111
192.168.1.112
192.168.1.113
192.168.1.121

# [optional] harbor server, a private docker registry
# 'NEW_INSTALL': 'yes' to install a harbor server; 'no' to integrate with existed one
[harbor]
192.168.1.111 HARBOR_DOMAIN="harbor.k8s116.curiouser.com" NEW_INSTALL=yes

# [optional] loadbalance for accessing k8s from outside
[ex-lb]
192.168.1.111 LB_ROLE=backup EX_APISERVER_VIP=192.168.1.150 EX_APISERVER_PORT=8443
192.168.1.112 LB_ROLE=master EX_APISERVER_VIP=192.168.1.150 EX_APISERVER_PORT=8443

# [optional] ntp server for the cluster
[chrony]
192.168.1.111

[all:vars]
# --------- Main Variables ---------------
# Cluster container-runtime supported: docker, containerd
CONTAINER_RUNTIME="docker"

# Network plugins supported: calico, flannel, kube-router, cilium, kube-ovn
CLUSTER_NETWORK="calico"

# Service proxy mode of kube-proxy: 'iptables' or 'ipvs'
PROXY_MODE="ipvs"

# K8S Service CIDR, not overlap with node(host) networking
SERVICE_CIDR="10.68.0.0/16"

# Cluster CIDR (Pod CIDR), not overlap with node(host) networking
CLUSTER_CIDR="172.20.0.0/16"

# NodePort Range
NODE_PORT_RANGE="20000-40000"

# Cluster DNS Domain
CLUSTER_DNS_DOMAIN="cluster.local."

# -------- Additional Variables (don't change the default value right now) ---
# Binaries Directory
bin_dir="/opt/kube/bin"

# CA and other components cert/key Directory
ca_dir="/etc/kubernetes/ssl"

# Deploy Directory (kubeasz workspace)
base_dir="/etc/ansible"
```

## 6.执行ansible playbook

```
ansible-playbook /etc/ansible/90.setup.yml
```

# 三、部署最新版Harbor

最新kubeasz安装脚本中不支持安装最新版本的harbor,所以要修改ansible安装脚本

## 1.下载最新版本harbor的离线安装到/etc/ansible/downdown

```bash
export harbor_version=v1.10.0 
curl -x 192.168.1.9:15388 -C- -fL --retry 3 https://github.com/goharbor/harbor/releases/download/${harbor_version}/harbor-offline-installer-${harbor_version}.tgz -o /etc/ansible/down/harbor-offline-installer-${harbor_version}.tgz 
```

## 2.新建haror配置模板文件

```bash
/etc/ansible/roles/harbor/templates/harbor-${harbor_version%.*}.cfg.j2
```

```yaml
# Configuration file of Harbor
# The IP address or hostname to access admin UI and registry service.DO NOT use localhost or 127.0.0.1, because Harbor needs to be accessed by external clients.
hostname: harbor.k8s116.curiouser.com
# http related config
http:
  # port for http, default is 80. If https enabled, this port will redirect to https port
  port: 80

# https related config
# https:
#   # https port for harbor, default is 443
#   port: 443
#   # The path of cert and key files for nginx
#   certificate: /your/certificate/path
#   private_key: /your/private/key/path

# Uncomment external_url if you want to enable external proxy. And when it enabled the hostname will no longer used external_url: https://reg.mydomain.com:8433

# The initial password of Harbor admin. It only works in first time to install harbor. Remember Change the admin password from UI after launching Harbor.
harbor_admin_password: Harbor12345

# Harbor DB configuration
database:
  # The password for the root user of Harbor DB. Change this before any production use.
  password: root123
  # The maximum number of connections in the idle connection pool. If it <=0, no idle connections are retained.
  max_idle_conns: 50
  # The maximum number of open connections to the database. If it <= 0, then there is no limit on the number of open connections.
  # Note: the default number of connections is 100 for postgres.
  max_open_conns: 100

# The default data volume
data_volume: /data

# Harbor Storage settings by default is using /data dir on local filesystem.Uncomment storage_service setting If you want to using external storage
# storage_service:
#   # ca_bundle is the path to the custom root ca certificate, which will be injected into the truststore
#   # of registry's and chart repository's containers.  This is usually needed when the user hosts a internal storage with self signed certificate.
#   ca_bundle:

#   # storage backend, default is filesystem, options include filesystem, azure, gcs, s3, swift and oss
#   # for more info about this configuration please refer https://docs.docker.com/registry/configuration/
#   filesystem:
#     maxthreads: 100
#   # set disable to true when you want to disable registry redirect
#   redirect:
#     disabled: false

# Clair configuration
clair:
  # The interval of clair updaters, the unit is hour, set to 0 to disable the updaters.
  updaters_interval: 12

jobservice:
  # Maximum number of job workers in job service
  max_job_workers: 10

notification:
  # Maximum retry count for webhook job
  webhook_job_max_retry: 10

chart:
  # Change the value of absolute_url to enabled can enable absolute url in chart
  absolute_url: disabled

# Log configurations
log:
  # options are debug, info, warning, error, fatal
  level: info
  # configs for logs in local storage
  local:
    # Log files are rotated log_rotate_count times before being removed. If count is 0, old versions are removed rather than rotated.
    rotate_count: 50
    # Log files are rotated only if they grow bigger than log_rotate_size bytes. If size is followed by k, the size is assumed to be in kilobytes.
    # If the M is used, the size is in megabytes, and if G is used, the size is in gigabytes. So size 100, size 100k, size 100M and size 100G
    # are all valid.
    rotate_size: 200M
    # The directory on your host that store log
    location: /var/log/harbor

  # Uncomment following lines to enable external syslog endpoint.
  # external_endpoint:
  #   # protocol used to transmit log to external endpoint, options is tcp or udp
  #   protocol: tcp
  #   # The host of external endpoint
  #   host: localhost
  #   # Port of external endpoint
  #   port: 5140

#This attribute is for migrator to detect the version of the .cfg file, DO NOT MODIFY!
_version: 1.10.0

# Uncomment external_database if using external database.
# external_database:
#   harbor:
#     host: harbor_db_host
#     port: harbor_db_port
#     db_name: harbor_db_name
#     username: harbor_db_username
#     password: harbor_db_password
#     ssl_mode: disable
#     max_idle_conns: 2
#     max_open_conns: 0
#   clair:
#     host: clair_db_host
#     port: clair_db_port
#     db_name: clair_db_name
#     username: clair_db_username
#     password: clair_db_password
#     ssl_mode: disable
#   notary_signer:
#     host: notary_signer_db_host
#     port: notary_signer_db_port
#     db_name: notary_signer_db_name
#     username: notary_signer_db_username
#     password: notary_signer_db_password
#     ssl_mode: disable
#   notary_server:
#     host: notary_server_db_host
#     port: notary_server_db_port
#     db_name: notary_server_db_name
#     username: notary_server_db_username
#     password: notary_server_db_password
#     ssl_mode: disable

# Uncomment external_redis if using external Redis server
# external_redis:
#   host: redis
#   port: 6379
#   password:
#   # db_index 0 is for core, it's unchangeable
#   registry_db_index: 1
#   jobservice_db_index: 2
#   chartmuseum_db_index: 3

# Uncomment uaa for trusting the certificate of uaa instance that is hosted via self-signed cert.
# uaa:
#   ca_file: /path/to/ca

# Global proxy
# Config http proxy for components, e.g. http://my.proxy.com:3128. Components doesn't need to connect to each others via http proxy. Remove component from `components` array if want disable proxy for it. If you want use proxy for replication, MUST enable proxy for core and jobservice, and set `http_proxy` and `https_proxy`. Add domain to the `no_proxy` field, when you want disable proxy for some special registry.
proxy:
  http_proxy:
  https_proxy:
  # no_proxy endpoint will append to already contained list: 127.0.0.1,localhost,.local,.internal,log,db,redis,nginx,core,portal,postgresql,jobservice,registry,registryctl,clair,chartmuseum,notary-server
  no_proxy:
  components:
    - core
    - jobservice
    - clair 
```
## 3.修改部署task配置文件

/etc/ansible/roles/harbor/defaults/main.yml中harbor的版本号
```
# harbor version，完整版本号，目前支持 v1.5.x , v1.6.x, v1.7.x
#======修改处=======
HARBOR_VER: "v1.10.0"                          
# harbor 主版本号，目前支持主版本号 v1.5/v1.6/v1.7，从完整版本号提取出主版本号 v1.5/v1.6/v1.7
HARBOR_VER_MAIN: "{{ HARBOR_VER.split('.')[0] }}.{{ HARBOR_VER.split('.')[1] }}"
```

## 4.修改部署task

因为新版本Harbor的配置文件不再叫harbor.cfg，而是harbor.yml,所以要修改具体安装harbor的task文件。

/etc/ansible/roles/harbor/tasks/main.yml  

```yaml
- name: 创建data目录
  file:
    path: /data
    state: directory
    mode: 0755
# 注册变量result，如果/data目录下存在registry目录说明已经安装过harbor，则不进行安装
- name: 注册变量result
  command: ls /data
  register: result
- block:
    - name: 下发docker compose二进制文件
      copy: src={{ base_dir }}/bin/docker-compose dest={{ bin_dir }}/docker-compose mode=0755
    - name: 下发harbor离线安装包
      copy:
        src: "{{ base_dir }}/down/harbor-offline-installer-{{ HARBOR_VER }}.tgz"
        dest: "/data/harbor-offline-installer-{{ HARBOR_VER }}.tgz"
    - name: 解压harbor离线安装包
      shell: "cd /data && tar zxf harbor-offline-installer-{{ HARBOR_VER }}.tgz"
    - name: 导入harbor所需 docker images
      shell: "{{ bin_dir }}/docker load -i /data/harbor/harbor.{{ HARBOR_VER }}.tar.gz"
    - name: 分发证书相关
      copy: src={{ base_dir }}/.cluster/ssl/{{ item }} dest={{ ca_dir }}/{{ item }}
      with_items:
      - ca.pem
      - ca-key.pem
      - ca-config.json
    - name: 创建harbor证书请求
      template: src=harbor-csr.json.j2 dest={{ ca_dir }}/harbor-csr.json
    - name: 创建harbor证书和私钥
      shell: "cd {{ ca_dir }} && {{ bin_dir }}/cfssl gencert \
            -ca={{ ca_dir }}/ca.pem \
            -ca-key={{ ca_dir }}/ca-key.pem \
            -config={{ ca_dir }}/ca-config.json \
            -profile=kubernetes harbor-csr.json | {{ bin_dir }}/cfssljson -bare harbor"
    - name: 配置 harbor.cfg 文件
    # =======修改处===============
      template: src=harbor-{{ HARBOR_VER_MAIN }}.cfg.j2 dest=/data/harbor/harbor.yml
    - name: 安装 harbor
      shell: "cd /data/harbor && \
        export PATH={{ bin_dir }}:$PATH && \
         ./install.sh  --with-clair"
  when: '"registry" not in result.stdout'
```

## 5.执行ansible-playbook

```bash
ansible-playbook /etc/ansible/11.harbor.yml
```

