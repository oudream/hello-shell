#!/usr/bin/env bash

### java8
https://docs.oracle.com/javase/8/docs/technotes/tools/unix/java.html
### java9
https://docs.oracle.com/en/java/javase/11/
https://docs.oracle.com/en/java/javase/11/tools/tools-and-command-reference.html

### install java on windows
# C:\Program Files (x86)\Common Files\Oracle\Java\javapath

### install java on ubuntu
sudo apt install openjdk-8-jdk
# sudo apt install openjdk-11-jdk
vim /etc/environment # or /etc/profile
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
# export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin

### java variable on macos
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export HADOOP_HOME=/usr/local/hadoop
export PATH=$PATH:$HADOOP_HOME/bin

### UPDATE THESE URLs
export JDK_URL=http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz
export UNLIMITED_STRENGTH_URL=http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip
# Download Oracle Java 8 accepting the license
wget --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
${JDK_URL}
# Extract the archive
tar -xzvf jdk-*.tar.gz
# clean up the tar
rm -fr jdk-*.tar.gz
# mk the jvm dir
sudo mkdir -p /usr/lib/jvm
# move the server jre
sudo mv jdk1.8* /usr/lib/jvm/oracle_jdk8

# install unlimited strength policy
wget --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
${UNLIMITED_STRENGTH_URL}
unzip jce_policy-8.zip
mv UnlimitedJCEPolicyJDK8/local_policy.jar /usr/lib/jvm/oracle_jdk8/jre/lib/security/
mv UnlimitedJCEPolicyJDK8/US_export_policy.jar /usr/lib/jvm/oracle_jdk8/jre/lib/security/

sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/oracle_jdk8/jre/bin/java 2000
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/oracle_jdk8/bin/javac 2000

sudo echo "export J2SDKDIR=/usr/lib/jvm/oracle_jdk8
export J2REDIR=/usr/lib/jvm/oracle_jdk8/jre
export PATH=$PATH:/usr/lib/jvm/oracle_jdk8/bin:/usr/lib/jvm/oracle_jdk8/db/bin:/usr/lib/jvm/oracle_jdk8/jre/bin
export JAVA_HOME=/usr/lib/jvm/oracle_jdk8
export DERBY_HOME=/usr/lib/jvm/oracle_jdk8/db" | sudo tee -a /etc/profile.d/oraclejdk.sh

### java 版本切换
## macos
export JAVA_HOME=$(/usr/libexec/java_home)
# export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
# export JAVA_HOME=$(/usr/libexec/java_home -v 11)
## linux
update-alternatives --config java
update-alternatives --config javac



### java
https://www.jianshu.com/p/87637b150026

    java [options] mainclass [args...]
    java [options] -jar jarfile [args...]

-cp classpath
# 指定JAVA搜寻类的类路径，会覆盖CLASSPATH环境变量的值。类路径为指定符号分隔（linux为冒号:，windows为分号;）的
# 目录、jar包路径或zip包路径，用来指定搜索class文件的路径。其详细说明可查看ClassPath详解。

-Dproperty=value
# 指定一个系统属性值。属性和属性值都为字符形式，其中属性名不能含有空白字符，属性值如果需要空白字符，需要使用双引号"包裹。
# 一个正确的示例如下：
-Dfoo="foo bar"
# 该值可以在JAVA程序中使用如下代码获取：
System.getProperty("foo")

-server -client
# 指定JVM的模式，client模式用于桌面应用，server模式用于服务端应用。JVM对两种模式有相应优化，
# client模式加载速度较快，可以快速启动；
# server模式加载速度较慢但运行起来较快。

-X
    -Xdebug           # provided for backward compatibility
    -Xmixed           # 混合模式执行 (默认)
    -Xint             # 仅解释模式执行
    -Xbootclasspath:<用 : 分隔的目录和 zip/jar 文件>
                      # 设置搜索路径以引导类和资源
    -Xbootclasspath/a:<用 : 分隔的目录和 zip/jar 文件>
                      # 附加在引导类路径末尾
    -Xbootclasspath/p:<用 : 分隔的目录和 zip/jar 文件>
                      # 置于引导类路径之前
    -Xdiag            # 显示附加诊断消息
    -Xnoclassgc       # 禁用类垃圾收集
    -Xincgc           # 启用增量垃圾收集
    -Xloggc:<file>    # 将 GC 状态记录在文件中 (带时间戳)
    -Xbatch           # 禁用后台编译
    -Xms<size>        # 设置初始 Java 堆大小
    -Xmx<size>        # 设置最大 Java 堆大小
    -Xss<size>        # 设置 Java 线程堆栈大小
    -Xprof            # 输出 cpu 配置文件数据
    -Xfuture          # 启用最严格的检查, 预期将来的默认值
    -Xrs              # 减少 Java/VM 对操作系统信号的使用 (请参阅文档)
    -Xcheck:jni       # 对 JNI 函数执行其他检查
    -Xshare:off       # 不尝试使用共享类数据
    -Xshare:auto      # 在可能的情况下使用共享类数据 (默认)
    -Xshare:on        # 要求使用共享类数据, 否则将失败。
    -XshowSettings    # 显示所有设置并继续
    -XshowSettings:all
                      # 显示所有设置并继续
    -XshowSettings:vm # 显示所有与 vm 相关的设置并继续
    -XshowSettings:properties
                      # 显示所有属性设置并继续
    -XshowSettings:locale
                      # 显示所有与区域设置相关的设置并继续


# 运行jar文件中的class
java -cp test.jar com.ee2ee.test.PackageTest
java xx # 执行class，不需要class后缀，加了报错
java -cp
java -jar # 执行jar文件，需要为可执行jar


### hello
https://www.jianshu.com/p/e42dc0652b6d
## 无package
cat >> HelloA.java <<EOF
public class HelloA{
    public static void main(String[] args) {
        System.out.println("hi HelloA");
    }
}
EOF

javac HelloA.java
java -cp . HelloA


## 有package
mkdir -p com/test

cat >> com/test/HelloB.java <<EOF
package com.test;
public class HelloB{
    public static void main(String[] args) {
        System.out.println("hi HelloB");
    }
}
EOF
javac com/test/HelloB.java
# 或者直接在hello2.java所在目录下执行
javac HelloB.java

java -cp . com.test.HelloB # 在任意位置指定classpath，也就是代码的根目录


## 无package ui
cat >> HelloC.java <<EOF
import java.awt.Dialog;
import java.awt.Label;
import java.awt.Window;
public class HelloC{
    public static void main(String[] args) {
        Dialog d = new Dialog(((Window)null),"Hello world!");
        d.setBounds(0, 0, 180, 70);
        d.add(new Label("hi Hello3"));
        d.setVisible(true);
    }
}
EOF

javac HelloC.java
java -cp . HelloC





### MANIFEST.MF
#    1. Manifest-Version
#    用来定义manifest文件的版本，例如：Manifest-Version: 1.0
#    2. Created-By
#    声明该文件的生成者，一般该属性是由jar命令行工具生成的，例如：Created-By: Apache Ant 1.5.1
#    3. Signature-Version
#    定义jar文件的签名版本
#    4. Class-Path
#    应用程序或者类装载器使用该值来构建内部的类搜索路径

Manifest-Version: 1.0
Main-Class: com.hejing.paserTsp.ShowResultFrame
Class-Path: lib/commons-beanutils-1.8.0.jar
 lib/byte-buddy-1.7.5.jar
 lib/client-combined-3.8.1.jar
 lib/client-combined-3.8.1-sources.jar
 lib/commons-codec-1.10.jar
 lib/commons-collections-3.2.1.jar
 lib/commons-exec-1.3.jar
 lib/commons-lang-2.5.jar
 lib/commons-logging-1.1.1.jar

