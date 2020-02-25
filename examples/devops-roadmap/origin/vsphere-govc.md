# vSphere go命令行管理工具govc

# 一、简介

VMware vSphere APIs (ESXi and/or vCenter)的go语言客户端

- [govc](https://github.com/vmware/govmomi/blob/master/govc) - vSphere CLI
- [vcsim](https://github.com/vmware/govmomi/blob/master/vcsim) - vSphere API mock framework
- [toolbox](https://github.com/vmware/govmomi/blob/master/toolbox) - VM guest tools framework

支持的ESXi / vCenter版本：

-  ESXi / vCenter 6.0, 6.5 , 6.7 (5.5和5.1版本功能部分支持, 但官方不再支持)

**GitHub地址**：https://github.com/vmware/govmomi

**govc下载地址**：https://github.com/vmware/govmomi/releases

**govc使用手册**：https://github.com/vmware/govmomi/blob/master/govc/USAGE.md

# 二、安装配置

## 1、安装

在[govc下载地址](https://github.com/vmware/govmomi/releases)下载对应平台的二进制包

```bash
curl -L $URL_TO_BINARY | gunzip > /usr/local/bin/govc
chmod +x /usr/local/bin/govc
```

MacOS对应`govc_darwin_amd64.gz`

## 2、配置

govc是通过设置环境变量进行配置的。

- `GOVC_URL`：ESXi或vCenter实例的地址

  默认协议`https` ，URL路径为 `/sdk` 。可在URL中设置用户名密码，例如： `https://user:pass@host/sdk`.

  如果用户名密码中包含特殊字符( `\`, `#` , `:`)，可以在 `GOVC_USERNAME` ， `GOVC_PASSWORD` 单独设置用户名密码。

- `GOVC_USERNAME`：用户名

- `GOVC_PASSWORD`：密码

- `GOVC_TLS_CA_CERTS`：指定CA证书

  ```bash
  $ export GOVC_TLS_CA_CERTS=~/.govc_ca.crt
  # 多证书设置
  $ export GOVC_TLS_CA_CERTS=~/ca-certificates/bar.crt:~/ca-certificates/foo.crt
  ```

- `GOVC_TLS_KNOWN_HOSTS`：指定验证证书的指纹

  ```bash
  $ export GOVC_TLS_KNOWN_HOSTS=~/.govc_known_hosts
  $ govc about.cert -u host -k -thumbprint | tee -a $GOVC_TLS_KNOWN_HOSTS
  $ govc about -u user:pass@host
  ```

- `GOVC_TLS_HANDSHAKE_TIMEOUT`: TLS握手的超时时间

- `GOVC_INSECURE`：关闭证书验证

  ```bash
  export GOVC_INSECURE=1
  ```

- `GOVC_DATACENTER`：

- `GOVC_DATASTORE`：

- `GOVC_NETWORK`：

- `GOVC_RESOURCE_POOL`：

- `GOVC_HOST`：

- `GOVC_GUEST_LOGIN`：

- `GOVC_VIM_NAMESPACE`：

- `GOVC_VIM_VERSION`：

以上变量可在`~/.zshrc或/etc/profile或~/.bashrc`中设置，同时可使用`govc env`查看设置。

# 三、常用命令

具体命令详解可查看文档：https://github.com/vmware/govmomi/blob/master/govc/USAGE.md

## 1、查询操作

### 查看所有VM

```bash
govc find . -type m
```

### 查看所有开机的VM

```bash
govc find . -type m -runtime.powerState poweredOn
```

## 2、VM电源的开启与关闭

```bash
vmname=test
# 开启VM电源
govc vm.power -on -M $vmname
# 关闭VM电源
govc vm.power -off -M $vmname
```

## 3、ESXI主机电源的管理

```bash
# 关闭ESXI主机电源
govc host.shutdown -f -host.ip ESXI_IP
```

## 4、在VM中进行的操作

### Prerequisite

- VM安装VMware-Tools工具后进行重启
  - 可直接使用包管理工具安装,例如:`yum install -y open-vm-tools`
  - 手动省略，太麻烦

- 设置要访问VM的名字及登录用户密码

  ```bash
  GOVC_GUEST_LOGIN="root:******"
  # 如果密码中包含特殊字符“!”，使用"\"进行转义."@"不需要转义
  vmname="test"
  ```

### 命令

```bash
govc guest.* -vm $vmname 
```

- **guest.chmod**：修改VM中文件的权限

- **guest.chown**：设置VM中文件的所有者

- **guest.df**：显示VM中文件的使用情况

  ```bash
  govc guest.df -vm $vmname
  ```

- **guest.download**：拷贝VM中的文件到本地

- **guest.getenv**：查看VM中的环境变量

- **guest.kill**：杀掉VM中的进程

- **guest.ls**：查看VM中的文件系统

  ```bash
  # 例如查看指定VM中“/root”下的文件夹
  govc guest.ls -vm $vmname /root
  ```

- **guest.mkdir**：在VM中创建文件夹

  ```bash
  govc guest.mkdir -vm $vmname /root/test
  ```

- **guest.mktemp**：在VM中创建临时文件或文件夹

- **guest.mv**：在VM中移动文件

- **guest.ps**：查看VM中的进程

- **guest.rm**：删除VM中的文件

- **guest.rmdir**：删除VM中的文件夹

- **guest.run**：在VM中运行命令，并显示输出结果

  ```bash
  Usage: govc guest.run [OPTIONS] PATH [ARG]...
  
  Examples:
    govc guest.run -vm $vmname ifconfig
    govc guest.run -vm $vmname ifconfig eth0
    cal | govc guest.run -vm $vmname -d - cat
    govc guest.run -vm $vmname -d "hello $USER" cat
    govc guest.run -vm $vmname curl -s :invalid: || echo $? # exit code 6
    govc guest.run -vm $vmname -e FOO=bar -e BIZ=baz -C /tmp env
  
  Options:
    -C=                    The absolute path of the working directory for the program to start
    -d=                    Input data string. A value of '-' reads from OS stdin
    -e=[]                  Set environment variables
    -i=false               Interactive session
    -l=:                   Guest VM credentials [GOVC_GUEST_LOGIN]
    -vm=                   Virtual machine [GOVC_VM]
  
  govc guest.run -l $GOVC_GUEST_LOGIN -vm $vmname sh -c /root/beforeShutDown.sh
  ```

- **guest.start**：在VM中启动程序，并显示输出结果

  ```bash
  Usage: govc guest.start [OPTIONS] PATH [ARG]...
  
  Examples:
    govc guest.start -vm $vmname /bin/mount /dev/hdb1 /data
    pid=$(govc guest.start -vm $vmname /bin/long-running-thing)
    govc guest.ps -vm $vmname -p $pid -X
  
  Options:
    -C=                    The absolute path of the working directory for the program to start
    -e=[]                  Set environment variable (key=val)
    -i=false               Interactive session
    -l=:                   Guest VM credentials [GOVC_GUEST_LOGIN]
    -vm=                   Virtual machine [GOVC_VM]
  ```

- **guest.touch**：在VM中创建文件

- **guest.upload**：上传本地文件到VM中

  ```bash
  govc guest.upload -vm $vmname ./**.tar.gz /root/***.tar.gz
  ```

  









