#!/usr/bin/env bash

# 使用setfacl和getfacl命令来设置或观察文件/目录的acl权限.

setfacl [-bkRd] [{-m|-x} acl参数] 文件/目录名
-m    # 配置后面的 acl 参数给文件/目录使用,不可与 -x 合用;
-x    # 删除后续的 acl 参数,不可与 -m 合用;
-b    # 移除所有的 ACL 配置参数;
-k    # 移除默认的 ACL 参数;
-R    # 递归配置 acl;
-d    # 配置“默认 acl 参数”,只对目录有效,在该目录新建的数据会引用此默认值;

getfacl 文件/目录名

