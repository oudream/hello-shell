讲师_@王晓春

@[TOC](本意内容)


# SELinux

## SELinux介绍
>SELinux：Security-Enhanced Linux， 是美国国家安全局(NSA=The National Security Agency)和SCC(Secure Computing Corporation)开发的 Linux的一个强制访问控制的安全模块。2000年以GNU GPL发布，Linux内核2.6版本后集成在内核中

+ DAC：Discretionary Access Control自由访问控制
       1. DAC环境下进程是无束缚的

+ MAC：Mandatory Access Control 强制访问控制
       1. MAC环境下策略的规则决定控制的严格程度
       2. MAC环境下进程可以被限制的
       3. 策略被用来定义被限制的进程能够使用那些资源（文件和端口）
       4. 默认情况下，没有被明确允许的行为将被拒绝

+ 字段：
       1. `Identify`身份识别：unconfined_u(不受限用户)，system_u(系统用户)
       2. `Role`角色：object_r(文件目录等资源)，system_r(进程)
       3. `Type`类型：文件称类型Type，进程称领域domain

+ SELinux模式：
       1. `enforcing`:强制模式，正常运行
       2. `permissive`:仅警告
       3. `disabled`:关闭

![在这里插入图片描述](https://img-blog.csdnimg.cn/2019060415583123.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90aHNvbi5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

## 配置SELinux
+ 配置文件:
`/etc/selinux/config`
`/etc/sysconfig/selinux`
SELINUX={disabled|enforcing|permissive}

## 命令：getenforce
+ 查看当前SELinux模式

```bash
[root@localhost ~]$getenforce
Enforcing
```

## 命令：setenforce
+ 修改SELinux模式

```bash
[root@localhost ~]$ setenforce 0
[root@localhost ~]$ getenforce
Permissive
#0为permissvie，1为enforce
```

+ 也可以修改内核
在内核参数后加上selinux=0

## 命令：sestatus
+ SELiunx状态

```bash
[root@localhost ~]$sestatus
SELinux status:                 enabled
SELinuxfs mount:                /sys/fs/selinux
SELinux root directory:         /etc/selinux
Loaded policy name:             targeted
Current mode:                   enforcing
Mode from config file:          enforcing
Policy MLS status:              enabled
Policy deny_unknown status:     allowed
Max kernel policy version:      31
```

## 命令：restorecon 
+ 恢复文件原来的selinux上下文

```bash
[root@localhost ~]$ restorecon filename
```

## 命令：getsebool 
+ 查看SELinux规则的bool值

```bash
#查看所有
[root@localhost ~]$ getsebool -a | head -10
abrt_anon_write --> off
abrt_handle_event --> off
abrt_upload_watch_anon_write --> on
antivirus_can_scan_system --> off
antivirus_use_jit --> off
auditadm_exec_content --> on
authlogin_nsswitch_use_ldap --> off
authlogin_radius --> off
authlogin_yubikey --> off
```

## 命令：setsebool
semanage boolean –l
semanage boolean -l –C 查看修改过的布尔值
设置bool值命令：
setsebool [-P] boolean value（on,off）
setsebool [-P] Boolean=value（1，0）


## 命令：seinfo
+ 查看SELinux规则(需要安装setools)

[OPTION]|注释
-|-
-A |所有
-u | 查看user种类
-r | 查看role种类
-t | 查看type种类
-b | 查看所有规则

```bash
[root@localhost ~]$seinfo

Statistics for policy file: /sys/fs/selinux/policy
Policy Version & Type: v.31 (binary, mls)

   Classes:           129    Permissions:       267
   Sensitivities:       1    Categories:       1024
   Types:            4774    Attributes:        258
   Users:               8    Roles:              14
   Booleans:          315    Cond. Expr.:       361
   Allow:          106707    Neverallow:          0
   Auditallow:        155    Dontaudit:       10045
   Type_trans:      18058    Type_change:        74
   Type_member:        35    Role allow:         39
   Role_trans:        416    Range_trans:      5899
   Constraints:       143    Validatetrans:       0
   Initial SIDs:       27    Fs_use:             32
   Genfscon:          102    Portcon:           613
   Netifcon:            0    Nodecon:             0
   Permissives:         0    Polcap:              5
```

## 命令：semanage
+ 默认安全上下文查询与修改 semanage(policycoreutils-python)
1. 查看默认的安全上下文
`semanage fcontext –l`
2. 添加安全上下文
`semanage fcontext -a –t httpd_sys_content_t ‘/testdir(/.*)?’`
`restorecon –Rv /testdir`
3. 删除安全上下文
`semanage fcontext -d –t httpd_sys_content_t ‘/testdir(/.*)?’`
4. c查看端口标签
`semanage port –l`
5. 添加端口
`semanage port -a -t port_label -p tcp|udp PORT`
例：`semanage port -a -t http_port_t -p tcp 9527`
6. 删除端口
`semanage port -d -t port_label -p tcp|udp PORT`
例：`semanage port -d -t http_port_t -p tcp 9527`
7. 修改现有端口为新标签
`semanage port -m -t port_label -p tcp|udp PORT`
例：`semanage port -m -t http_port_t -p tcp 9527`

## 命令：chcon
+ 给文件重新打安全标签：
`chcon [OPTION]... [-u USER] [-r ROLE] [-t TYPE] FILE...`
`chcon [OPTION]... --reference=RFILE FILE...`
-R：递归打标

## 命令：sesearch
+ 查看SELinux规则
`sesearch [-A] [-s 主体类别] [-t 目标类别] [-b 布尔值]`
-A ：列出后面允许读取或放行的数据
-t 类别 ：目标类别
-b 规则 ：布尔值



# SELinux日志管理
+ 命令：setroubleshoot(需要setroubleshoot包)
+ 将错误的信息写入/var/log/message
`grep setroubleshoot /var/log/messages`
+ 查看安全事件日志说明
`sealert -l UUID`
+ 扫描并分析日志
`sealert -a /var/log/audit/audit.log`

# SELinux帮助
1. `yum –y install selinux-policy-doc`
2. `mandb | makewhatis`
3. `man -k _selinux`

# 练习
1、启用SELinux策略并安装httpd服务，改变网站的默认主目录为/website,添加SELinux文件标签规则，使网站可访问
2、修改上述网站的http端口为9527，增加SELinux端口标签，使网站可访问
3、启用相关的SELinux布尔值，使上述网站的用户student的家目录可通过http访问
4、编写脚本selinux.sh，实现开启或禁用SELinux功能