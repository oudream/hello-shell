#!/usr/bin/env bash

# https://maven.apache.org/
# https://maven.apache.org/download.cgi

# install on windows
# 添 加 MAVEN_HOME 环 境 变 量 ， 值 为 MAVEN 的 解 压 缩 目 录 。 把 MAVEN 的 bin 目 录
# （%MAVEN_HOME%\bin）加入系统的 Path 环境变量
MAVEN_HOME=D:\tools\maven-3
# 运行命令提示符（cmd），输入 mvn -v 并回车测试 Maven 是否安装成功，

cd $MAVEN_HOME
cat >> conf/settings.conf <<EOF
  <mirrors>
    <mirror>
      <id>nexus-aliyun</id>
      <mirrorOf>central</mirrorOf>
      <name>Nexus aliyun</name>
      <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
    </mirror>
  </mirrors>
EOF
