# 二进制方式安装Elasticsearch

# 一、简介



官方文档：https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html

# 二、手工部署安装

## 1. Prerequisites

### **配置系统文件描述符限制**

修改/etc/security/limits.conf文件追加如下内容(es运行用户为elasticsearch)

```yaml
elasticsearch        hard     nofile         65535
elasticsearch        soft     nofile         65535
```



### **创建相应文件夹**



## 2. 下载二进制安装包

二进制安装包下载地址：https://www.elastic.co/cn/downloads/past-releases

## 3. 修改配置

## 4. 使用Systemd管理生命周期

# 三、Ansible工具部署安装

Ansible脚本GitHub地址：https://github.com/elastic/ansible-elasticsearch



