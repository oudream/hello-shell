
export NODE_IPS=(172.17.0.10 172.17.0.11 172.17.0.12 172.17.0.13)
export NODE_NAMES=(server1 node1 node2 node3)


### emptryDir
# emptryDir，顾名思义是一个空目录，它的生命周期和所属的 Pod 是完全一致的。
#    emptyDir 类型的 Volume 在 Pod 分配到 Node 上时会被创建，Kubernetes 会在 Node 上自动分配一个目录，
#    因此无需指定 Node 宿主机上对应的目录文件。这个目录的初始内容为空，当 Pod 从 Node 上移除
#    （Pod 被删除或者 Pod 发生迁移）时，emptyDir 中的数据会被永久删除。
# emptyDir Volume 主要用于某些应用程序无需永久保存的临时目录，在多个容器之间共享数据等。
#    缺省情况下，emptryDir 是使用主机磁盘进行存储的。你也可以使用其它介质作为存储，
#    比如：网络存储、内存等。设置 emptyDir.medium 字段的值为 Memory 就可以使用内存进行存储，
#    使用内存做为存储可以提高整体速度，但是要注意一旦机器重启，内容就会被清空，并且也会受到容器内存的限制。

apiVersion: v1
kind: Pod
metadata:
  name: test-pd
spec:
  containers:
  - image: gcr.io/google_containers/test-webserver
    name: test-container
    volumeMounts:
    - mountPath: /cache
      name: cache-volume
  volumes:
  - name: cache-volume
    emptyDir: {}



### hostPath
# hostPath 类型的 Volume 允许用户挂载 Node 宿主机上的文件或目录到 Pod 中。大多数 Pod 都用不到这种 Volume，
# 其缺点比较明显，比如：
#    由于每个节点上的文件都不同，具有相同配置（例如：从 podTemplate 创建的）的 Pod 在不同节点上的行为可能会有所不同。
#    在底层主机上创建的文件或目录只能由 root 写入。您需要在特权容器中以 root 身份运行进程，
#    或修改主机上的文件权限才可以写入 hostPath 卷。
# 当然，存在即合理。这种类型的 Volume 主要用在以下场景中：
#    运行中的容器需要访问 Docker 内部的容器，使用 /var/lib/docker 来做为 hostPath 让容器内应用可以直接访问
#        Docker的文件系统。
#    在容器中运行 cAdvisor，使用 /dev/cgroups 来做为 hostPath。
#    和 DaemonSet 搭配使用，用来操作主机文件。例如：日志采集方案 FLK 中的 FluentD 就采用这种方式来加载主机的
#        容器日志目录，达到收集本主机所有日志的目的。

apiVersion: v1
kind: Pod
metadata:
  name: test-pd
spec:
  containers:
  - image: k8s.gcr.io/test-webserver
    name: test-container
    volumeMounts:
    - mountPath: /test-pd
      name: test-volume
  volumes:
  - name: test-volume
    hostPath:
      # directory location on host
      path: /data
      # this field is optional
      type: Directory


### nfs NFS
sudo apt install nfs-kernel-server
sudo mkdir -p /data/kubernetes/
sudo chmod 755 /data/kubernetes/
sudo vim /etc/exports
cat >> /etc/exports << EOF
/data/kubernetes  *(rw,sync,no_root_squash)
EOF

# 启动 NFS 服务端
sudo systemctl restart nfs-kernel-server
# 验证 NFS 服务端是否正常启动
sudo rpcinfo -p|grep nfs

# 查看具体目录挂载权限
cat /var/lib/nfs/etab

# 安装 NFS 客户端
sudo apt-get install nfs-common
# 验证 RPC 服务状态
sudo systemctl status rpcbind.service
# 检查 NFS 服务端可用的共享目录
sudo showmount -e ${NODE_IPS[0]}
# 挂载 NFS 共享目录到本地
sudo mkdir -p /data/kubernetes/
sudo mount -t nfs ${NODE_IPS[0]}:/data/kubernetes/ /data/kubernetes/


# 在 NFS 客户端新建
sudo touch /data/kubernetes/test.txt
# 在 NFS 服务端查看
sudo ls -ls /data/kubernetes/

### 实现静态 PV :

cat >> pv1-nfs.yaml << EOF
apiVersion: v1
kind: PersistentVolume
metadata:
  name:  pv1-nfs
spec:
  capacity:
    storage: 1Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Recycle
  nfs:
    server: ${NODE_IPS[0]}
    path: /data/kubernetes
EOF

kubectl create -f pv1-nfs.yaml


cat >> pvc1-nfs.yaml << EOF
apiVersion: v1
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: pvc1-nfs
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
EOF

kubectl create -f pvc1-nfs.yaml


cat >> pvc2-nfs.yaml << EOF
apiVersion: v1
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: pvc2-nfs
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
  selector:
    matchLabels:
      app: nfs
EOF

kubectl create -f pvc2-nfs.yaml


cat >> pv2-nfs.yaml << EOF
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv2-nfs
  labels:
    app: nfs
spec:
  capacity:
    storage: 2Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Recycle
  nfs:
    server: ${NODE_IPS[0]}
    path: /data/kubernetes
EOF

kubectl create -f pv2-nfs.yaml


### 使用 PVC 资源
# 这里我们已经完成了 PV 和 PVC 创建，现在我们就可以使用这个 PVC 了。
#    这里我们使用 Nginx 的镜像来创建一个 Deployment，将容器的 /usr/share/nginx/html 目录通过 Volume
#    挂载到名为 pvc2-nfs 的 PVC 上，并通过 NodePort 类型的 Service 来暴露服务。

cat >> nfs-pvc-deploy.yaml << EOF
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: nfs-pvc
spec:
  replicas: 3
  template:
    metadata:
      labels:
        app: nfs-pvc
    spec:
      containers:
      - name: nginx
        image: nginx:1.7.9
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
          name: web
        volumeMounts:
        - name: www
          mountPath: /usr/share/nginx/html
      volumes:
      - name: www
        persistentVolumeClaim:
          claimName: pvc2-nfs

---

apiVersion: v1
kind: Service
metadata:
  name: nfs-pvc
  labels:
    app: nfs-pvc
spec:
  type: NodePort
  ports:
  - port: 80
    targetPort: web
  selector:
    app: nfs-pvc
EOF

kubectl create -f nfs-pvc-deploy.yaml

kubectl get pods -o wide|grep nfs-pvc


curl -I http://${NODE_IPS[0]}:80

sudo sh -c "echo '<h1>Hello Kubernetes~</h1>' > /data/kubernetes/index.html"

curl -I http://${NODE_IPS[0]}:80

# 使用 subPath 对同一个 PV 进行隔离
vim nfs-pvc-deploy.yaml

#...
#volumeMounts:
#- name: www
#  subPath: nginx-pvc-test
#  mountPath: /usr/share/nginx/html
#...
IFS_B=IFS;IFS=;s1="$(sed -n '/mountPath/p' nfs-pvc-deploy.yaml)"; \
s2=$(echo $s1 | sed -e 's/mountPath:\(.*\)$/subPath: nginx-pvc-test/'); \
sed -i.bak "/mountPath/ i \\${s2}" nfs-pvc-deploy.yaml; \
IFS=IFS_B;
