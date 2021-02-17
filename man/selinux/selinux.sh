#!/usr/bin/env bash


setenforce [Enforcing|Permissive|1|0]

booleans
setsebool
sepolicy
system-config-selinux
togglesebool
restorecon
fixfiles
setfiles
semanage
sepolicy


setenforce 0
### 修改 SELinux 启动模式、临时生效
# 命令：setenforce [0|1]
# 0：转成 permissive 宽容模式；
# 1：转成 Enforcing 强制模式；
### 永久生效，需要重启
# 修改 /etc/selinux/config 文件中的 SELINUX="" 为 disabled

getenforce
# # 查看 当前 SELinux 模式
# 命令：getenforce

# # 修改 SElinux 启动模式、永久生效 重启生效
# 命令：vim /etc/selinux/config
cat >> /etc/selinux/config <<EOF
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=enforcing
# SELINUXTYPE= can take one of three values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected.
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted
EOF

ps -eZ | grep cron
# # 查看 指定主体程序type类型
# 命令：ps -eZ | grep cron
# 解析：ps -eZ | grep 筛选主体

getsebool -a
#  # 查看 系统系统全部 SELinux 规则的启动关闭
# 命令：getsebool -a
# -a：列出目前系统上面所有 SELinux 规则的布林值为开放或者关闭
# 同功能命令：semanage boolean -l

seinfo --all
# # 查看 SELinux 总信息统计状态、安装包：setools-console-*
# 命令：seinfo
# 格式：seinfo [-trub]
# --all：列出 SELinux 的状态、规则布林值、身份识别、角色、类别等所有信息
# -u：列出 SELinux 的所有身份识别 uesr 种类
# -r：列出 SELinux 的所有身份 role 种类
# -t：列出 SELinux 的所有身份 type 种类
# -b：列出所有规则的种类 布林值
#  输出信息

sesearch -A -s crond_t | grep spool
# # 查看 指定type类型再 SELinux 中被赋予的权限规则
# 命令1：sesearch -A -s crond_t | grep spool
# 解析：sesearch -A -s 主体type | grep 塞选字段

sesearch -A -b httpd_enable_homedirs
# 命令2：sesearch -A -b httpd_enable_homedirs
# 解析：sesearch -A -b 布林值
# 格式：sesearch [-A] [-s 主体类别=程序type] [-t 目标类别] [-b 布林值=文件目录type]
# -A：列出读取或放行的相关信息
#  输出信息

ll -Z
# # 查看 文件目录或程序的 SELinux 权限信息
# 命令：ll -Z 文件/目录
# 命令：ls -Z 文件/目录

setsebool -P httpd_enable_homedirs  1
# # 关闭/启动 SElinux type 规则
# 命令：setsebool -P httpd_enable_homedirs  1
# 解析：setsebool -P 规则  1
# 格式：setsebool [-P] 『规则名称』 [0|1]
# -P：直接将设定值写入文件，永久生效。
# 1：打开
# 0：关闭

chcon -v --reference=/etc/shadow  /etc/cron.d/checktime
# # 修改 SELinux 文件主体，角色，类型、通过示例文件实现
# 命令：chcon -v --reference=/etc/shadow  /etc/cron.d/checktime
# 解析：chcon -v --reference=示例文件目录  赋值文件目录
# 格式1：chcon [-R] [-t type] [-u user] [-r role] 目录文件
# 格式2：chcon [-R] --reference=示例目录文件 目录文件
# -R：连同子目录同时修改。
# -t：后面接type类型。列如：httpd_sys_content_t。
# -u：后面接身份识别。列如：system_u。
# -r：后面跟角色，列如：system_r。
# -v：若有变化成功，请将变动的结果列出来
# --reference=示例目录文件：拿某个文件目录来修订改动后续接的文件目录类型。

restorecon -Rv /etc/cron.d
# # 恢复 SELinux 赋值的默认预设权限及目录
# 命令：restorecon -Rv /etc/cron.d
# 解析：restorecon -Rv 文件目录
# 格式：restorecon [-Rv] 檔案或目錄
# -R：连同子目录同事修改。
# -v：将过程打印到终端。

semanage fcontext -l | grep '^/srv/mycron'
# # 查看 筛选 SELinux 下指定类型规则的作用范围
# 命令：semanage fcontext -l | grep '^/srv/mycron'
# 解析：semanage fcontext -l | grep 作用范围

semanage fcontext -a -t system_cron_spool_t "/srv/mycron(/.*)?"
# # 添加 SELinux 预设type类型
# 命令：semanage fcontext -a -t system_cron_spool_t "/srv/mycron(/.*)?"
# 解析：semanage fcontext -a -t type规则  作用范围
# 格式1：semanage {login|user|port|interface|fcontext|translation} -l
# 格式2：semanage fcontext -{a|d|m} [-frst] file_spec
# fcontext：主要用在安全性文本方面的用途。
# -l：为查询的意思。
# -a：增加的意思，你可以增加一些目录的预设的安全性文本预设。
# -m：修改的意思。
# -d：删除的意思。

rpm -qa | grep setroubleshoot
# # 查看 SElinux 日志服务监控是否安装
# 命令：rpm -qa | grep setroubleshoot
# 安装服务名称：auditd、setroubleshootd


#SELinux 初探
open http://cn.linux.vbird.org/linux_basic/0440processcontrol_5.php#selinux_policy
#　　5.1 什么是 SELinux： 目标, DAC, MAC
#　　5.2 SELinux 的运行模式： 组件, 安全性本文, domain/type
#　　5.3 SELinux 的启动、关闭与观察： getenforce, sestatus, 启动与关闭, setenforce
#　　5.4 SELinux 网络服务运行范例： 启动 (ps -Z), 错误情况, 解决 (chcon, restorecon)
#　　5.5 SELinux 所需的服务： setroubleshoot, sealert, auditd, audit2why
#　　5.6 SELinux 的政策与守则管理： seinfo, sesearch, getsebool, setsebool, semanage

# SELinux - NSA Security-Enhanced Linux (SELinux)

open https://en.wikipedia.org/wiki/Security-Enhanced_Linux
open http://www.nsa.gov/research/selinux

#DESCRIPTION
    # NSA  Security-Enhanced Linux (SELinux) is an implementation of a flexible mandatory access control architecture in the
    # Linux operating system.  The SELinux architecture provides general support for the enforcement of many kinds of manda‐
    # tory  access control policies, including those based on the concepts of Type Enforcement®, Role- Based Access Control,
    # and Multi-Level Security.   Background  information  and  technical  documentation  about  SELinux  can  be  found  at
    # http://www.nsa.gov/research/selinux.

    # The  /etc/selinux/config  configuration  file controls whether SELinux is enabled or disabled, and if enabled, whether
    # SELinux operates in permissive mode or enforcing mode.  The SELINUX variable may be set to any one of  disabled,  per‐
    # missive,  or enforcing to select one of these options.  The disabled option completely disables the SELinux kernel and
    # application code, leaving the system running without any  SELinux  protection.   The  permissive  option  enables  the
    # SELinux  code,  but  causes  it  to  operate in a mode where accesses that would be denied by policy are permitted but
    # audited.  The enforcing option enables the SELinux code and causes it to enforce access denials as  well  as  auditing
    # them.  Permissive mode may yield a different set of denials than enforcing mode, both because enforcing mode will pre‐
    # vent an operation from proceeding past the first denial and because some application code will fall  back  to  a  less
    # privileged mode of operation if denied access.

    # The /etc/selinux/config configuration file also controls what policy is active on the system.  SELinux allows for mul‐
    # tiple policies to be installed on the system, but only one policy may be active at any given time.  At present, multi‐
    # ple  kinds of SELinux policy exist: targeted, mls for example.  The targeted policy is designed as a policy where most
    # user processes operate without restrictions, and only specific services are placed into distinct security domains that
    # are  confined by the policy.  For example, the user would run in a completely unconfined domain while the named daemon
    # or apache daemon would run in a specific domain tailored to its operation.  The MLS (Multi-Level Security)  policy  is
    # designed  as  a  policy where all processes are partitioned into fine-grained security domains and confined by policy.
    # MLS also supports the Bell And LaPadula model, where processes are not only confined by the type but also the level of
    # the data.

    # You  can  define which policy you will run by setting the SELINUXTYPE environment variable within /etc/selinux/config.
    # You must reboot and possibly relabel if you change the policy type to have it take effect on the system.   The  corre‐
    # sponding policy configuration for each such policy must be installed in the /etc/selinux/{SELINUXTYPE}/ directories.

    # A  given  SELinux policy can be customized further based on a set of compile-time tunable options and a set of runtime
    # policy booleans.  system-config-selinux allows customization of these booleans and tunables.

    # Many domains that are protected by SELinux also include SELinux man pages explaining how to customize their policy.

#FILE LABELING
    # All files, directories, devices ... have a security context/label associated with them.  These context are  stored  in
    # the  extended attributes of the file system.  Problems with SELinux often arise from the file system being mislabeled.
    # This can be caused by booting the machine with a non SELinux kernel.  If you see an error message  containing  file_t,
    # that is usually a good indicator that you have a serious problem with file system labeling.

    # The  best  way to relabel the file system is to create the flag file /.autorelabel and reboot.  system-config-selinux,
    # also has this capability.  The restorecon/fixfiles commands are also available for relabeling files.
#SEE ALSO
    # booleans(8), setsebool(8), sepolicy(8), system-config-selinux(8), togglesebool(8), restorecon(8), fixfiles(8),
    # setfiles(8), semanage(8), sepolicy(8)
