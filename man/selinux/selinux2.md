# selinux笔记<!-- omit in toc -->

1. [运行模式](#运行模式)
2. [更改安全上下文：](#更改安全上下文)
3. [查看Selinux规则](#查看selinux规则)
4. [查看/添加Selinux模块](#查看添加selinux模块)
5. [查看/修改bool值](#查看修改bool值)
6. [查看/分析Selinux日志，并解决问题](#查看分析selinux日志并解决问题)

## 运行模式

> 强制访问控制（Mandatory Access Control，MAC）：通过`selinux`的默认规则来控制进程的权限
>
> 自主访问控制系统（Discretionary Access Control，DAC）：通过`user`、`group`、`rwx`来控制不同用户对不同文件的读写执行权限，`root`用户不受到限制，特殊权限`SetUID`可以使普通用户以`root`权限执行拥护`SetUID`权限的程序
>
> 开启`selinux`后必须同时满足`MAC`和`DAC`规则才可以正确运行程序

* 主体(Subject):
  访问文件或目录资源的进程

* 目标(Object):
  需要访问的文件或目录资源

* 策略(Policy):
  > 通过`cat /etc/sysconfig/selinux`来查看`selinux`的状态和默认策略

  Selinux默认定义了三个策略，规则都已经在这三个策略中写好了，默认只要调用策略就可以正常使用了。这两个默认策略如下：
  * `targeted`：这是 SELinux 的默认策略，这个策略主要是限制网络服务的，对本机系统的限制极少。我们使用这个策略已经足够了。
  * `mls`: 完整的SELinux 限制，限制方面较为严格。
  * `minimum`：由`target`修订而来，仅针对选择的程序来保护！

* 安全上下文(Security Context): 每个进程、目录和文件都有自己的安全上下文，进程能否访问目录/文件，需要判断两者的安全上下文是否匹配，然后进行比较，符合就通过，不符合就`AVC`拒绝

![selnux运行模式](image/selinux运行模式.jpg "selinux运行模式图示")

主体的访问请求首先和`Selinux`中定义好的策略进行匹配，如果进程符合策略中定义的规则，就把进程的安全上下文和目标的安全上下文进行匹配，如果失败则访问拒绝，并通过`AVC`（`Access Vector Cache`，访问向量缓存，主要用于记录所有和 SELinux 相关的访问统计信息)生成拒绝访问信息，如果安全上下文匹配，则通过`Selinux`控制

## 更改安全上下文：

* 查看文件的安全上下文：

    ```sh
    # 查看文件的安全上下文
    ls -Z
    # 查看进程的安全上下文
    ps -auxZ
    ```

    如上所是的`root:object_r:user_home_t`对应为：身份识别(Identify):角色(role):类型(type)

* `restorecon`:
    恢复目录或者程序的默认安全上下文

    ```sh
    sudo restorecon -Rv -f /var/sshd
    ```

* `chcon`:

    ```sh
    sudo chcon -R -t ssh_home_t ~/.ssh/authorized_keys
    ```

* `semanage`:
    添加到默认规则里，以后使用`restorecon`即可恢复，不会存在下载就没有了

    ```sh
    # 查看文件安全上下文的默认类型
    $ sudo semanage fcontext -l

    # 更改文件安全上下文的默认类型
    $ sudo semanage fcontext -a -t public_content_t "/srv/samba(/.*)?"
    restorecon -Rv /srv/samba*
    $ sudo ls -Zd /srv/samba
    drwxr-xr-x  root root system_u:object_r:public_content_t /srv/samba/

    # 查看网络端口限制
    $ sudo semanage port -l | grep ssh
    ssh_port_t                     tcp      22
    $ sudo semanage port -a -t ssh_port_t -p tcp 3322
    $ sudo semanage port -l | grep ssh
    ssh_port_t                     tcp      3322, 22

    # 其他参数请通过 `semanage --help` 或 `man semanage` 查看
    ```

## 查看Selinux规则

* `sesearch`:

    ```sh
    # 查看类型为 inetd_t 的selinux规则
    sesearch -A -t inetd_t
    ```

* `seinfo`:

    ```sh
    # 查看所有的类型
    seinfo -b
    ```

## 查看/添加Selinux模块

> `SELinux`策略是一系列的模块化规则集合，安装时它会基于已经安装的服务自动探测并启用相关模块。系统立即可操作。然而，如果一个服务是在 SELinux 策略之后安装的，就要手动启用相应模块了。semodule 命令可以实现该目的。还必须用 semanage 命令，定义每个用户可用的角色。

* `semanage`:

    ```sh
    # 查看所有模块
    semanage module -l
    # 禁用一个模块
    semanage module --disable unconfined
    # 安装一个模块
    semanage module -a myapache
    # 查看其他参数
    semanage module --help
    man semanage module
  ```

* `semodule`:

    ```sh
    # Install or replace a base policy package.
    semodule -b base.pp
    # Install or replace a non-base policy package.
    semodule -i httpd.pp
    # Install or replace all non-base modules in the current directory.
    # This syntax can be used with -i/u/r/E, but no other option can be entered after the module names
    semodule -i *.pp
    # Install or replace all modules in the current directory.
    ls *.pp | grep -Ev "base.pp|enableaudit.pp" | xargs /usr/sbin/semodule -b base.pp -i
    # List non-base modules.
    semodule -l
    # List all modules including priorities
    semodule -lfull
    # Remove a module at priority 100
    semodule -X 100 -r wireshark
    # Turn on all AVC Messages for which SELinux currently is "dontaudit"ing.
    semodule -DB
    # Turn "dontaudit" rules back on.
    semodule -B
    # Disable a module (all instances of given module across priorities will be disabled).
    semodule -d alsa
    # Install a module at a specific priority.
    semodule -X 100 -i alsa.pp
    # List all modules.
    semodule --list=full
    # Set an alternate path for the policy root
    semodule -B -p "/tmp"
    # Set an alternate path for the policy store root
    semodule -B -S "/tmp/var/lib/selinux"
    # Write the HLL version of puppet and the CIL version of wireshark
    # modules at priority 400 to the current working directory
    semodule -X 400 --hll -E puppet --cil -E wireshark
    ```

## 查看/修改bool值

* `getsebool` or `setatus`

    ```sh
    # 查看所有bool
    getsebool -a
    sestatus -b
    ```

* `sesearch`
  查看一个`bool`包含的`selinux`规则

  ```sh
  # 查看 httpd_can_network_connect_db 布尔值包含的selinux规则
  sesearch -A -b httpd_can_network_connect_db
  ```

* `setsebool`

  ```sh
  # 允许vsvtp匿名用户写入权限：
  setsebool -P allow_ftpd_anon_write=1
  ```

## 查看/分析Selinux日志，并解决问题

* 启用`auditd`服务

    ```sh
    sudo dnf install audit
    sudo systemctl enable auditd
    sudo systemctl start auditd
    ```

* 查看`audit`日志
  * `audit2why`:

    ```sh
    # 查看本次启动所有关于selinux拒绝的信息，并给出解决方案，不过大部分没有0.0,并且不准确或者解决方案的权限过大
    sudo audit2why -b
    ```

  * `audit2allow`:

    ```sh
    # 详细查看selinux的avc拒绝信息
    sudo audit2allow -b
    ```

* 制作`selinux`模块,并安装

    如果不能通过修改`bool`值、文件安全上下文等来解决问题，可以通过`audit2allow`命令生成`selinux`模块并加载，来解决问题

    ```sh
    # 利用`audit2allow`生成`selinux`模块
    sudo audit2allwo -b -M local
    # 倒入`local`模块
    sudo semodule -i local.pp
    ```