# kubectl命令行配置多Kubernetes集群

# 一. 下载kubectl

kubectl github下载地址：https://github.com/kubernetes/kubectl/releases

# 二. 创建配置文件夹

**Linux**

  ```bash
  mkdir ~/.kube
  ```

**Windows CMD**

  ```bash
  mkdir %USERPROFILE%\.kube

  # %USERPROFILE%  当前用户目录  
  ```

# 三. 创建编辑kubectl配置文件

```yaml
apiVersion: v1
# 集群信息
clusters:
- cluster:
    certificate-authority-data: **CA证书***
    server: https://开发k8s环境APIServer的IP地址:6443
  name: k8s-dev
- cluster:
    certificate-authority-data: **CA证书***
    server: https://测试k8s环境APIServer的IP地址:8443
  name: k8s-test
- cluster:
    certificate-authority-data: **CA证书***
    server: https://UAT k8s环境APIServer的IP地址:8443
  name: k8s-uat
- cluster:
    certificate-authority-data: **CA证书***
    server: https://生产k8s环境APIServer的IP地址:8443
  name: k8s-pro
# 集群上下文环境
contexts:
- context:
    cluster: k8s-dev
    user: k8s-dev-admin
  name: k8s-dev
- context:
    cluster: k8s-test
    user: k8s-test-admin
  name: k8s-test
- context:
    cluster: k8s-uat
    user: k8s-uat-admin
  name: k8s-uat
- context:
    cluster: k8s-pro
    user: k8s-pro-readonly
  name: k8s-pro
# 当前使用的上下文环境  
current-context: k8s-dev
kind: Config
preferences: {}
#集群用户信息及证书信息
users:
- name: k8s-dev
  user:
    client-certificate-data: **用户证书**
    client-key-data： **用户私钥**
- name: k8s-test
  user:
    client-certificate-data: **用户证书**
    client-key-data： **用户私钥**
- name: k8s-uat
  user:
    client-certificate-data: **用户证书**
    client-key-data： **用户私钥**
- name: k8s-pro
  user:
    client-certificate-data: **用户证书**
    client-key-data： **用户私钥**

```

# 四. 切换Kubernetes集群上下文

```bash
#切换至开发k8s环境上下文
kubectl config use-context k8s-dev

#切换至开发k8s环境上下文
kubectl config use-context k8s-test

#切换至开发k8s环境上下文
kubectl config use-context k8s-uat

#切换至开发k8s环境上下文
kubectl config use-context k8s-pro
```

# 五. kubectl命令的别名和快速切换集群上下文的别名

1. 设置别名快速使用kubectl命令

    **Windows**

    ```bash
    doskey  k=kubectl $*
    # $*表示这个命令还可能有其他参数
    ```

    **Linux**

    ```bash
    alias k='kubectl'
    ```

2. 设置别名快速切换Kubectl集群上下文

    **Windows**

    ```bash
    doskey k2d=kubectl config use-context k8s-dev
    doskey k2t=kubectl config use-context k8s-test
    doskey k2u=kubectl config use-context k8s-uat
    doskey k2p=kubectl config use-context k8s-pro
    ```

    **Linux**

    ```bash
    alias k2d='kubectl config use-context k8s-dev'
    alias k2t='kubectl config use-context k8s-test'
    alias k2u='kubectl config use-context k8s-uat'
    alias k2p='kubectl config use-context k8s-pro'
    ```

3. Windows和Linux下设置别名永久生效

**Windows**
   - ①创建bat脚本cmdalias.cmd
       ```bash
       @doskey k=kubectl $*
       @doskey k2d=kubectl config use-context k8s-dev
       @doskey k2t=kubectl config use-context k8s-test
       @doskey k2u=kubectl config use-context k8s-uat
       @doskey k2p=kubectl config use-context k8s-pro
       # @表示执行这条命令时不显示这条命令本身
       ```

   - ②修改注册表
     - `方式1`：手动在注册HKEY_CURRENT_USER\Software\Microsoft\Command Processor下添加一项AutoRun，把值设为bat脚本的路径
     - `方式2`：创建编写一个注册表修改文件，名为：add-regkey.reg，双击行这个文件,导入注册表添加的值

            Windows Registry Editor Version 5.00
            [HKEY_CURRENT_USER\Software\Microsoft\Command Processor]
            "AutoRun"="%USERPROFILE%\\.kube\\cmdalias.cmd"
  
       
       

  **Linux**


    echo "alias k='kubectl'" >> /etc/profile && \
    echo "alias k2d='kubectl config use-context k8s-dev'" >> /etc/profile && \
    echo "alias k2t='kubectl config use-context k8s-test'" >> /etc/profile && \
    echo "alias k2u='kubectl config use-context k8s-uat'" >> /etc/profile && \
    echo "alias k2p='kubectl config use-context k8s-pro'" >> /etc/profile && \
    source /etc/profile


# 六. Kubectl Config命令详解

   ```bash
  1. If the --kubeconfig flag is set, then only that file is loaded.  The flag may only be set once and no merging takes
place.
  2. If $KUBECONFIG environment variable is set, then it is used a list of paths (normal path delimitting rules for your
system).  These paths are merged.  When a value is modified, it is modified in the file that defines the stanza.  When a
value is created, it is created in the first file that exists.  If no files in the chain exist, then it creates the last
file in the list.
  3. Otherwise, ${HOME}/.kube/config is used and no merging takes place.

  Usage:
      kubectl config SUBCOMMAND [options]

  Available Commands:
      current-context Displays the current-context
      delete-cluster  Delete the specified cluster from the kubeconfig
      delete-context  Delete the specified context from the kubeconfig
      get-clusters    Display clusters defined in the kubeconfig
      get-contexts    Describe one or many contexts
      rename-context  Renames a context from the kubeconfig file.
      set             Sets an individual value in a kubeconfig file
      set-cluster     Sets a cluster entry in kubeconfig
      set-context     Sets a context entry in kubeconfig
      set-credentials Sets a user entry in kubeconfig
      unset           Unsets an individual value in a kubeconfig file
      use-context     Sets the current-context in a kubeconfig file
      view            Display merged kubeconfig settings or a specified kubeconfig file
   ```

# 参考连接
1. https://blog.csdn.net/u013360850/article/details/83315188
2. https://www.awaimai.com/2445.html
