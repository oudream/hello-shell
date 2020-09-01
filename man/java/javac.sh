#!/usr/bin/env bash

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