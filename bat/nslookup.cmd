rem 查询一个域名的A记录。
nslookup domain [dns-server]

rem 查询其他记录，比如AAAA、MX等。
nslookup -qt=type domain [dns-server]
rem 其中，type可以是以下这些类型：
rem    A 地址记录
rem    AAAA 地址记录
rem    AFSDB Andrew文件系统数据库服务器记录
rem    ATMA ATM地址记录
rem    CNAME 别名记录
rem    HINFO 硬件配置记录，包括CPU、操作系统信息
rem    ISDN 域名对应的ISDN号码
rem    MB 存放指定邮箱的服务器
rem    MG 邮件组记录
rem    MINFO 邮件组和邮箱的信息记录
rem    MR 改名的邮箱记录
rem    MX 邮件服务器记录
rem    NS 名字服务器记录
rem    PTR 反向记录
rem    RP 负责人记录
rem    RT 路由穿透记录
rem    SRV TCP服务器信息记录
rem    TXT 域名对应的文本信息
rem    X25 域名对应的X.25地址记录

nslookup -qt=mx baidu.com 8.8.8.8
rem    *** Invalid option: qt=mx
rem    Server:     8.8.8.8
rem    Address:    8.8.8.8#53

rem 查询更具体的信息
nslookup –d [其他参数] domain [dns-server]
rem 只要在查询的时候，加上-d参数，即可查询域名的缓存。
