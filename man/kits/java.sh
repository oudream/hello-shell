#!/usr/bin/env bash

export JAVA_HOME=/usr/lib/jvm/java-8-oracle
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export HADOOP_HOME=/usr/local/hadoop
export PATH=$PATH:$HADOOP_HOME/bin



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


# 运行jar文件中的class
java -cp test.jar com.ee2ee.test.PackageTest
java xx # 执行class，不需要class后缀，加了报错
java -cp
java -jar # 执行jar文件，需要为可执行jar



### javac
javac [ options ] [ sourcefiles ] [ @argfiles ]
# options：
   -g                       # 生成所有调试信息
   -g:none                  # 不生成任何调试信息
   -g:{lines,vars,source}   # 只生成某些调试信息
   -nowarn                  # 不生成任何警告
   -verbose                 # 输出有关编译器正在执行的操作的消息
   -deprecation             # 输出使用已过时的 API 的源位置
   -classpath <path>        # 指定查找用户类文件的位置
   -cp <path>               # 指定查找用户类文件的位置
   -sourcepath <path>       # 指定查找输入源文件的位置
   -bootclasspath <path>    # 覆盖引导类文件的位置
   -extdirs <dir>           # 覆盖安装的扩展目录的位置
   -endorseddirs <dir>      # 覆盖签名的标准路径的位置
   -d <dir>                 # 指定存放生成的类文件的位置
   # 使用-d参数，如类中定义了包，则编译时会自动生成包，  如：javac -d .  helloworld.java
   # 表示在当前目录下编译Helloworld 类。.表示当前目录，如helloword中定义有包，则在当前目录下生成包：
   -encoding <编码>          # 指定源文件使用的字符编码
   -source <版本>            # 提供与指定版本的源兼容性
   -target <版本>            # 生成特定 VM 版本的类文件
   -version                 # 版本信息
   -help                    # 输出标准选项的提要
   -X                       # 输出非标准选项的提要
   -J<标志>                  # 直接将 <标志> 传递给运行时系统

javac -d targetdir xx.java # 指定class输出的目录
javac -encoding utf-8 xx.java # 指定字符集
javac -cp classpath:jars xx.java # 指定classpath
javac -verbose xx.java # 输出编译细节




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

