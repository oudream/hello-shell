[toc]

# 负载均衡简介
负载均衡(Load Balance，简称LB)是一种服务或基于硬件设备等实现的高可用反向代理技术，负载均衡将特定的业务(web服务、网络流量等)分担给指定的一个或多个后端特定的服务器或设备，从而提高了公司业务的并发处理能力、保证了业务的高可用性、方便了业务后期的水平动态扩展。

## 为什么使用负载均衡
1. Web服务器的动态水平扩展-->对用户无感知
2. 增加业务并发访问及处理能力-->解决单服务器瓶颈问题
3. 节约公网IP地址-->降低IT支出成本
4. 隐藏内部服务器IP-->提高内部服务器安全性
5. 配置简单-->固定格式的配置文件
6. 功能丰富-->支持四层和七层，支持动态下线主机
7. 性能较强-->并发数万甚至数十万

## 负载均衡类型
**四层：**
1、LVS(Linux Virtual Server)
2、HAProxy(High Availability Proxy)
3、Nginx()
**七层：**
1、HAProxy
2、Nginx
**硬件：**
1、F5 ：https://f5.com/zh
2、Netscaler ：https://www.citrix.com.cn/products/citrix-adc/
3、Array ：https://www.arraynetworks.com.cn/
4、深信服 ：http://www.sangfor.com.cn/
5、北京灵州 ：http://www.lingzhou.com.cn/cpzx/llfzjh/

## 应用场景
四层：Redis、Mysql、RabbitMQ、Memcache等
七层：Nginx、Tomcat、Apache、PHP 、图片、动静分离、API等


# HAProxy简介

> HAProxy是法国开发者 威利塔罗(Willy Tarreau) 在2000年使用C语言开发的一个开源软件，是一款具备高并发(一万以上)、高性能的TCP和HTTP负载均衡器，支持基于cookie的持久性，自动故障切换，支持正则表达式及web状态统计，目前最新TLS版本为2.0

haproxy是高可用代理软件，是一种免费，快速且可靠的解决方案，可为基于TCP和HTTP的应用程序提供高可用性，负载平衡和代理。

它特别适用于流量非常高的网站，并为世界上访问量最大的网站提供支持。
多年来，它已成为事实上的标准开源负载均衡器，现在随大多数主流Linux发行版一起提供，并且通常默认部署在云平台中。
由于它不会自我宣传，我们只知道它在管理员报告时使用:它的操作模式使其与现有体系结构的集成非常容易且无风险，同时仍然提供了不将脆弱的Web服务器暴露给网络的可能性，如下所示：

## HAProxy功能
**HAProxy功能：**
```bash
TCP和HTTP反向代理
SSL/TSL服务器
可以针对HTTP请求添加cookie，进行路由后端服务器
可平衡负载至后端服务器，并支持持久连接
支持基于cookie进行调度
支持所有主服务器故障切换至备用服务器
支持专用端口实现监控服务
支持不影响现有连接情况下停止接受新连接请求
可以在双向添加，修改或删除HTTP报文首部
响应报文压缩
支持基于pattern实现连接请求的访问控制
通过特定的URI为授权用户提供详细的状态信息
```

**不具备的功能：**
```bash
正向代理--squid
缓存代理--varnish
web服务--nginx、tengine、apache、php、tomcat
UDP--目前不支持UDP协议，2.1版本会支持UDP协议代理
单机性能--LVS
```

