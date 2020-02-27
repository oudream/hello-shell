
### [企业生产环境用户sudo权限集中管理项目方案案例](https://blog.slogra.com/post-583.html)
> 服务器用户权限管理改造方案与实施项目步骤：  
    1. 在了解公司业务流程后，提出权限整改解决方案改进公司超级权限root泛滥在现状  
    2. 我首先撰写了方案后，给老大看，取得老大的支持后，召集大家开会讨论  
    3. 讨论确定可行后，由我负责推进实施  
    4. 实施后结果，公司的服务器权限管理更加清晰了(总结维护)  
    5. 制定了账号权限申请流程及权限申请表格  
 
### 问题现状：
> 当前我们公司里服务器上百台，各个服务器上的管理人员很多(开发+运维+架构+DBA+产品+市场)，在大家登陆使用Linux服务器时，
>不同职能的员工水平不同，因为导致操作很不规范，root权限泛滥（几乎大部分人员都有root权限），经常导致文件等莫名其妙的丢失，
>老手和新手员工对服务器的熟知度也不同，这样使得公司服务器安全存在很大的不稳定性、及操作安全隐患，据调查企业服务器环境，
>50%以上的安全问题都来自于内部，而不是外部。为了解决以上问题，单个用户管理权限过大现状，
>现提出针对Linux服务器用户权限集中管理的解决方案：
 
### 项目需求：
> 我们既希望超级用户root密码掌握在少数或唯一的管理员手中，又希望多个系统管理员或相关有权限的人员，
>能够完成更多更复杂的自身职能相关的工作，又不至于越权操作导致系统安全隐患。
 
### 具体实现：
> 针对公司不同部门，根据员工的具体工作职能（例如：开发，运维，数据库管理员），分等级、分层次的实现对
>linux服务器管理权限最少化、规范化。这样即减少了运维管理成本，消除了安全隐患，又提高了工作效率，实现了高质量的、快速化的完成项目进度，
>以及日常系统维护。
 
### 实施方案：
> 说明：实施方案一般是由积极主动发现问题的运维人员提出方案，然后写好方案，在召集大家讨论可行性，最后确定方案，实施部署，
> 最后后期总结维护。  
> 思想：在提出问题之前，一定要想到如何解决，一并发出来解决方案。
 
### 信息采集：
#### 召集相关各部门领导通过会议讨论或与各组领导沟通确定权限管理方案的可行性。  
- 需要支持的人员：运维经理、CTO支持、各部门组的领导。我们作为运维人员，拿到类似这项目方案，给大家讲解这个文档，通过会谇形式做演讲，慷慨激昂的演说，取得大佬们的支持和认可，才是项目能够得以最终实施的前提，当然，即使不实施，那么你的能力也得到了锻炼，老大对你的积极主动思考网站架构问题也会另眼看待。  
- 确定方案可行性后，会议负责人汇总、提交、审核所有相关员工对linux服务器的权限需求。  
- 取得老大们的支持后，通过发邮件或者联系相关人员取得需要的相关员工权限信息。比如说，请名部门经理整理归类本部门需要登录linux权限的人员名单、职位、及负责的业务及权限，如果说不清楚权限细节，就说负责的业务细节，这样运维人员就可以确定需要啥权限了。  
- 按照需要执行的linux命令程序及公司业务服务来规划权限和人员对应配置主要是运维人员根据上面收集的人员名单，需要的业务及权限角色，对应账号配置权限，实际就是配置sudo配置文件。  
- 权限方案一旦实施后，所有员工必须通过《员工linux服务器管理权限申请表》来申请对应的权限，确定审批流程，规范化管理。这里实施后把住权限申请流程很重要，否则，大家不听说，方案实施完也会泡汤的。  
- 写操作说明，对各部门人员进行操作讲解。sudo执行命令，涉及到PATH变量问题，运维提前处理好。  
收集员工职能和对应权限
此过程是召集大家开会确定，或者请各组领导安排人员进行统计汇总，人员及对应的工作职责，交给运维人员，由运维人员优化职位所对应的系统权限。
如：

1）运维组  
级别  
权限  

### 初级运维  
> 查看系统信息，查看网络状态
```
/usr/bin/free,/usr/bin/iostat,/usr/bin/top,/bin/hostname,/sbin/ifconfig,
/bin/netstat,/sbin/route
``` 

### 高级运维
>查看系统信息，查看和修改网格配置，进程管理，软件包管理，存储管理
```
/usr/bin/free,/usr/bin/iostat,/usr/bin/top,/bin/hostname,/sbin/ifconfig, 

/bin/netstat,/sbin/route,/sbin/iptables,/etc/init.d/network,/bin/nice,/bin/kill,
/usr/bin/kill,/usr/bin/killall,/bin/rpm,/usr/bin/up2date,/usr/bin/yum,
/sbin/fdisk,/sbin/sfdisk,/sbin/parted,/sbin/partprobe,/bin/mount,/bin/umount
```

### 运维经理
> 超级用户所有权限
ALL
 
### 2）开发组：  
> 级别	权限
初级开发	root的查看权限，对应服务查看日志的权限
```
/usr/bin/tail/app/log*,/bin/grep/app/log*,/bin/cat,/bin/ls
```

### 高级开发	root的查看权限，对应服务查看日志的权限，重启对应服务的权限
```
/sbin/service,/sbin/chkconfig,tail /app/log*,grep /app/log*,/bin/cat,/bin/ls, 

/bin/sh ~/scripts/deploy.sh
```

### 开发经理	项目所在服务器的ALL权限，不能修改root密码
```
ALL,!/usr/bin/passwd root,/usr/bin/passwd [A-Za-z]*,!/usr/bin/passwd root
``` 

### 3)架构组  
> 级别	权限  
架构工程师	普通用户的权限  
不加入sudo列表
 
 
### 4)DBA组：  
级别	权限  
初级DBA	普通用户的权限
不加入sudo列靓
高级DBA	项目所在数据库服务器的ALL权限
ALL, /usr/bin/passwd [A-Za-z]* !/usr/bin/passwd root, !/usr/sbin/visudo,
 
 
### 5)网络组  
> 级别	权限  
初级网络	普通用户权限  
不加入sudo列靓  
高级网络	项目所在数据库服务器的ALL权限  
```
/sbin/route,/sbin/ifconfig,/bin/ping,/sbin/dhclient,/usr/bin/net, 

/sbin/iptables,/usr/bin/rfcomm,/usr/bin/wvdial,/sbin/iwconfig,
/sbin/mii-tool,/bin/cat,/var/log/*
``` 

>例如：本公司有  
运维组：3个初级运维，1个高级运维，1个运维经理  
开发组：2个初级开发人员，1个高级开发，1个开发经理  
架构组：2个架构工程师（架构组不加入sudo）  
DBA组：3个初级DBA（初级DBA不加入sudo），1个高级DBA  
网络组：2个初级网管（初级DBA不加入sudo），1个高级网管  
 
 
### 模拟创建用户角色：
>运维组：  
3个初级运维，1个高级运维，1个运维经理  
密码统一是:111111  
```
for user in chujiyw001 chujiyw002 chujiyw003 ywsenior001 ywmanager001
do
useradd $user
echo "111111"|passwd --stdin $user
done
groupadd -g 555 chujiyw
gpasswd -a chujiyw001 chujiyw
gpasswd -a chujiyw002 chujiyw
gpasswd -a chujiyw003 chujiyw
```
 
### 开发组：  
> 2个初级开发人员，1个高级开发，1个开发经理  
密码统一是:111111  
```
for user in chujikf001 chujikf002 kfsenior001 kfmanager001
do
useradd $user
echo "111111"|passwd --stdin $user
done
groupadd -g 666 chujikf
gpasswd -a chujikf001 chujikf
gpasswd -a chujikf002 chujikf
``` 

### 架构组：
> 2个架构工程师 （因为架构组不加入sudo不用管它）
密码统一是:111111
```
for user in jiak001 jiak002
do
useradd $user
echo "111111"|passwd --stdin $user
done
``` 

### DBA组：
>3个初级DBA（初级DBA不加入sudo），1个高级DBA
密码统一是:111111
```
for user in chjidba001 chjidba002 chjidba003 dbasenior001
do
useradd $user
echo "111111"|passwd --stdin $user
done
``` 

### 网络组：2个初级网管（初级DBA不加入sudo），1个高级网管
> 密码统一是:111111
```
for user in chjidwg001 chjidwg002 wgsenior001
do
useradd $user
echo "111111"|passwd --stdin $user
done
``` 
 
### 首先定义一个命令别名：
```
# 运维组：
#yuwei Cmnd_Alias#
Cmnd_Alias CYW_CMD_1 = /usr/bin/free,/usr/bin/iostat,/usr/bin/top,/bin/hostname,/sbin/ifconfig,
/bin/netstat,/sbin/route
 
Cmnd_Alias GYW_CMD_1 = /usr/bin/free,/usr/bin/iostat,/usr/bin/top,/bin/hostname,/sbin/ifconfig,
/bin/netstat,/sbin/route,/sbin/iptables,/etc/init.d/network,/bin/nice,/bin/kill,/usr/bin/kill,
/usr/bin/killall,/bin/rpm,/usr/bin/up2date,/usr/bin/yum,/sbin/fdisk,/sbin/sfdisk,/sbin/parted,
/sbin/partprobe,/bin/mount,/bin/umount
 
# 开发组:
#kaifa Cmnd_Alias#
Cmnd_Alias CKF_CMD_1 = /usr/bin/tail /app/log*,/bin/grep/app/log*,/bin/cat,/bin/ls
Cmnd_Alias GKF_CMD_1 = /sbin/service,/sbin/chkconfig,/usr/bin/tail/app/log*,/bin/grep /app/log*,
/bin/cat,/bin/ls,/bin/sh ~/scripts/deploy.sh
Cmnd_Alias KFJL_CMD_1 = ALL,!/usr/bin/passwd root,/usr/bin/passwd [A-Za-z]*,!/usr/bin/passwd root
 
 
# DBA组：
#DBA#
Cmnd_Alias GJDBA_CMD_1 = ALL,!/usr/bin/passwd root,/usr/bin/passwd [A-Za-z]*,!/usr/bin/passwd root
 
# 网络：
#wangguan#
Cmnd_Alias GWG_CMD_1 = /sbin/route,/sbin/ifconfig,/bin/ping,/sbin/dhclient,/usr/bin/net,/sbin/iptables,
/usr/bin/rfcomm,/usr/bin/wvdial,/sbin/iwconfig,/sbin/mii-tool,/bin/cat,/var/log/*
``` 

### 定义用户别名：
```
##User_Alias by dingjian at 20121222##
User_Alias CHUJIADMINS = %chujiyw
User_Alias CHUJI_KAIFA = %chujikf
User_Alias GWGADMINS = wgsenior001
 
★设置Runas_Alias用户身份别名
##Runas_Alias by dingjian 20131222##
Runas_Alias OP = root
 
★命令与用户授权配置
## Allow root to run any commands anywhere
root    ALL=(ALL)       ALL
##set bydingjian at 20131222##
#yunwei#
CHUJIADMINS     ALL=(OP)     CYW_CMD_1
ywsenior001      ALL=(OP)     GYW_CMD_1
ywmanager001    ALL=(OP)     ALL
#kaifa#
CHUJI_KAIFA      ALL=(OP)     CKF_CMD_1
kfsenior001       ALL=(OP)      GKF_CMD_1
kfmanager001    ALL=(OP)      KFJL_CMD_1
#DBA#
dbasenior001     ALL=(OP)     GJDBA_CMD_1
#net#
GWGADMINS     ALL=(OP)     GWG_CMD_1
 ```

### sudoer配置内容如下：
```
##Cmd_Alias by dingjian at 20131222##
#yuwei Cmnd_Alias#
Cmnd_Alias CYW_CMD_1 = /usr/bin/free,/usr/bin/iostat,/usr/bin/top,/bin/hostname,
/sbin/ifconfig,/bin/netstat,/sbin/route
Cmnd_Alias GYW_CMD_1 = /usr/bin/free,/usr/bin/iostat,/usr/bin/top,/bin/hostname,/sbin/ifconfig,
/bin/netstat,/sbin/route,/sbin/iptables,/etc/init.d/network,/bin/nice,/bin/kill,/usr/bin/kill,/usr/bin/killall,
/bin/rpm,/usr/bin/up2date,/usr/bin/yum,/sbin/fdisk,/sbin/sfdisk,/sbin/parted,/sbin/partprobe,
/bin/mount,/bin/umount
 
#kaifa Cmnd_Alias#
Cmnd_Alias CKF_CMD_1 = /usr/bin/tail /app/log*,/bin/grep/app/log*,/bin/cat,/bin/ls
Cmnd_Alias GKF_CMD_1 = /sbin/service,/sbin/chkconfig,/usr/bin/tail/app/log*,/bin/grep /app/log*,
/bin/cat,/bin/ls,/bin/sh ~/scripts/deploy.sh
Cmnd_Alias KFJL_CMD_1 = ALL,!/usr/bin/passwd root,/usr/bin/passwd [A-Za-z]*,!/usr/bin/passwd root
#DBA#
Cmnd_Alias GJDBA_CMD_1 = ALL,!/usr/bin/passwd root,/usr/bin/passwd [A-Za-z]*,!/usr/bin/passwd root
 
#wangguan#
Cmnd_Alias GWG_CMD_1 = /sbin/route,/sbin/ifconfig,/bin/ping,/sbin/dhclient,/usr/bin/net,/sbin/iptables,
/usr/bin/rfcomm,/usr/bin/wvdial,/sbin/iwconfig,/sbin/mii-tool,/bin/cat,/var/log/*
 
##User_Alias by dingjian at 20121222##
User_Alias CHUJIADMINS = %chujiyw
User_Alias CHUJI_KAIFA = %chujikf
User_Alias GWGADMINS = wgsenior001
##Runas_Alias by dingjian 20131222##
Runas_Alias OP = root
## Allow root to run any commands anywhere
root    ALL=(ALL)       ALL
##set bydingjian at 20131222##
#yunwei#
CHUJIADMINS     ALL=(OP)     CYW_CMD_1
ywsenior001      ALL=(OP)     GYW_CMD_1
ywmanager001    ALL=(OP)     ALL
#kaifa#
CHUJI_KAIFA      ALL=(OP)     CKF_CMD_1
kfsenior001       ALL=(OP)      GKF_CMD_1
kfmanager001    ALL=(OP)      KFJL_CMD_1
#DBA#
dbasenior001     ALL=(OP)     GJDBA_CMD_1
#net#
GWGADMINS     ALL=(OP)     GWG_CMD_1
 ```

### 注意事项：  
1. 别名大写  
2. 路径要全路径  
3. 用”\”换行  
 
### 测试
4. 分别切换到每个用户下用sudo -l查看每个人所拥有的sudo权限
5. 实战调试测试
6. 成功后，发邮件周知所有人权限配置生效。并附带操作说明
有必要的话，培训讲解
7. 制定权限申请流程及申请表
8. 后期维护：不是特别紧急的需求，一律走申请流程
 

>服务多了，可以通过分发软件批量分发/etc/sudoers（注意权限和语法检查）
除了权限上的控制，在账户有效时间上也进行了限制，现在线上多数用户的权限为永久权限，
这样可以使用以下方法进行时间上的控制，这样才能让安全最好大化
 
>提示： 授权ALL在进行排除有时会让我们防不胜防，这程先开后关的策略并不是好的策略。
 
 
### sudo配置注意事项：
    a)命令别名下的成员必须是文件或目录的绝对路径
    b)别名名称是包含大写字母、数字、下划线，如果是字母都要大写。
    c)一个别名下有多个成员，成员与成员之间，通过半角“,”逗号分隔；成员必须是有效实际存在的。
    d)别名成员受别名类型Host_Alias、User_Alias、Runas_Alias、Cmnd_Alias制约，定义什么类型的别名，就要有什么类型的成员相配。
    e)别名规则是每行算一个规则，如果一个别名规则一行容不上时，可以通过“\”来续行
    f)指定切换的用户要用()括号括起来，如果省略括号，则默认为root用户；如果括号里是ALL，则代表能切换到所有用户
    g)如果不需要密码直接运行命令的，应该加NOPASSWD：参数
    h)禁止某程序或命令执行，要在命令动作前面加“！”号，并且放在允许执行命令的后面。
    i)用户组前面必须加%
 
### 总结方案流程
1. 在了解公司业务流程后，提出权限整改解决方案改进公司超级权限root泛滥的现状
2. 我首先撰写了方案后，给老大看，取得老大的支持后，召集大家开会讨论
3. 讨论确定可行后，推进实施
4. 实施后结果，公司的服务器权限管理更加清晰了（总结维护）
5. 制定了账号权限申请流程及权限申请表格