#!/usr/bin/env bash

# 解压
jar xvf original-esclient-0.0.1-SNAPSHOT.jar
# 压缩
# It has been compressed and nested jar files must be stored without compression.
# You shoud add -0 to store only; use no ZIP compression
# https://stackoverflow.com/questions/29999671/unable-to-run-repacked-spring-boot-jar-caused-by-unable-to-open-nested-entry
# manifest : m
jar -cvfm original-esclient-0.0.1-SNAPSHOT.jar META-INF/MANIFEST.MF META-INF/maven/ BOOT-INF/ org/


https://docs.oracle.com/javase/9/tools/jar.htm


jar tf test.jar


jar {ctxui}[vfmn0PMe] [jar-file] [manifest-file] [entry-point] [-C dir] files ...
# 参数其中{ctxu}这四个参数必须选选其一。
# [vfmn0PMe]是可选参数，文件名也是必须的。
# jar命令一般用来对jar包文件处理，jar包是由JDK安装目录\bin\jar.exe命令生成的，当我们安装好JDK，设置好path路径，
# 就可以正常使用jar.exe命令，它会用lib\tool.jar工具包中的类。此处以jdk1.8.0_181版本为例，语法：

-c # 创建一个jar包
-t # 显示jar中的内容列表
-x # 解压jar包
-u # 添加文件到jar包中
-i # 为指定的jar文件创建索引文件
-f # 指定jar包的文件名
-v # 生成详细的报造，并输出至标准设备
-m # 指定manifest.mf文件.(manifest.mf文件中可以对jar包及其中的内容作一些一设置)
-0 # 产生jar包时不对其中的内容进行压缩处理
-M # 不产生所有文件的清单文件(Manifest.mf)。这个参数与忽略掉-m参数的设置
-P # 保留文件名中的前导'/'（绝对路径）和“..”（父目录）组件
-e # 为独立应用程序指定应用程序入口点捆绑到可执行jar文件中
-C # 表示转到相应的目录下执行jar命令,相当于cd到那个目录，然后不带-C执行jar命令

# 以文件test创建test.jar
jar cf test.jar test
jar cf test.jar test.class

# 查看jar文件列表
jar tf test.jar

# 向test.jar中添加或更新文件
jar vuf test.jar a.txt

# 将命令执行的过程输出输出到文件a.txt中
jar vtf test.jar > a.txt

# 将jar中的文件解出到当前目录下
jar xf test.jar a.txt




### tutorial
https://docs.oracle.com/javase/tutorial/deployment/jar/build.html
jar cvf TicTacToe.jar TicTacToe.class audio images
jar cvf0 TicTacToe.jar TicTacToe.class audio images
jar cvf TicTacToe.jar *


jar cf ImageAudio.jar -C images . -C audio .
# The -C images part of this command directs the Jar tool to go to the images directory, and the .
# following -C images directs the Jar tool to archive all the contents of that directory.
# The -C audio . part of the command then does the same with the audio directory.

# The resulting JAR file would have this table of contents:
#
#    META-INF/MANIFEST.MF
#    cross.gif
#    not.gif
#    beep.au
#    ding.au
#    return.au
#    yahoo1.au
#    yahoo2.au


# By contrast, suppose that you used a command that did not employ the -C option:
jar cf ImageAudio.jar images audio

# The resulting JAR file would have this table of contents:

#    META-INF/MANIFEST.MF
#    images/cross.gif
#    images/not.gif
#    audio/beep.au
#    audio/ding.au
#    audio/return.au
#    audio/yahoo1.au
#    audio/yahoo2.au




### classpath
# https://www.liaoxuefeng.com/wiki/1252599548343744/1260466914339296
#    classpath是JVM用到的一个环境变量，它用来指示JVM如何搜索class。
#    classpath就是一组目录的集合，
#
#    在Windows系统上，用;分隔，带空格的目录用""括起来，可能长这样：
#    C:\work\project1\bin;C:\shared;"D:\My Documents\project1\bin"
#
#    在Linux系统上，用:分隔，可能长这样：
#    /usr/shared:/usr/local/bin:/home/liaoxuefeng/bin
#
#    现在我们假设classpath是.;C:\work\project1\bin;C:\shared，当JVM在加载abc.xyz.Hello这个类时，会依次查找：
#    <当前目录>\abc\xyz\Hello.class
#    C:\work\project1\bin\abc\xyz\Hello.class
#    C:\shared\abc\xyz\Hello.class
#
#    classpath的设定方法有两种：
#    在系统环境变量中设置classpath环境变量，不推荐；
#    在启动JVM时设置classpath变量，推荐。
#    我们强烈不推荐在系统环境变量中设置classpath，那样会污染整个系统环境。在启动JVM时设置classpath才是推荐的做法。实际上就是给java命令传入-classpath或-cp参数：

java -classpath .;C:\work\project1\bin;C:\shared abc.xyz.Hello
# 或者使用-cp的简写：
java -cp .;C:\work\project1\bin;C:\shared abc.xyz.Hello
# 没有设置系统环境变量，也没有传入-cp参数，那么JVM默认的classpath为.，即当前目录：

java abc.xyz.Hello
# 上述命令告诉JVM只在当前目录搜索Hello.class。

#    通常，我们在自己编写的class中，会引用Java核心库的class，例如，String、ArrayList等。这些class应该上哪去找？
#    有很多“如何设置classpath”的文章会告诉你把JVM自带的rt.jar放入classpath，但事实上，根本不需要告诉JVM如何去Java核心库查找class，JVM怎么可能笨到连自己的核心库在哪都不知道？
#    不要把任何Java核心库添加到classpath中！JVM根本不依赖classpath加载核心库！
#    更好的做法是，不要设置classpath！默认的当前目录.对于绝大多数情况都够用了。

## jar包
#    如果有很多.class文件，散落在各层目录中，肯定不便于管理。如果能把目录打一个包，变成一个文件，就方便多了。
#    jar包就是用来干这个事的，它可以把package组织的目录层级，以及各个目录下的所有文件（包括.class文件和其他文件）都打成一个jar文件，这样一来，无论是备份，还是发给客户，就简单多了。
#    jar包实际上就是一个zip格式的压缩文件，而jar包相当于目录。如果我们要执行一个jar包的class，就可以把jar包放到classpath中：
java -cp ./hello.jar abc.xyz.Hello
# 这样JVM会自动在hello.jar文件里去搜索某个类。

# 那么问题来了：如何创建jar包？
#    因为jar包就是zip包，所以，直接在资源管理器中，找到正确的目录，点击右键，在弹出的快捷菜单中选择“发送到”，
#    “压缩(zipped)文件夹”，就制作了一个zip文件。然后，把后缀从.zip改为.jar，一个jar包就创建成功。
#
#    假设编译输出的目录结构是这样：
#
#    package_sample
#    └─ bin
#       ├─ hong
#       │  └─ Person.class
#       │  ming
#       │  └─ Person.class
#       └─ mr
#          └─ jun
#             └─ Arrays.class
#    这里需要特别注意的是，jar包里的第一层目录，不能是bin，而应该是hong、ming、mr。如果在Windows的资源管理器中看，应该长这样：
#
#    hello.zip.ok
#
#    如果长这样：
#
#    hello.zip.invalid
#
#    说明打包打得有问题，JVM仍然无法从jar包中查找正确的class，原因是hong.Person必须按hong/Person.class存放，而不是bin/hong/Person.class。
#
#    jar包还可以包含一个特殊的/META-INF/MANIFEST.MF文件，MANIFEST.MF是纯文本，可以指定Main-Class和其它信息。
#    JVM会自动读取这个MANIFEST.MF文件，如果存在Main-Class，我们就不必在命令行指定启动的类名，而是用更方便的命令：
#
#    java -jar hello.jar
#    jar包还可以包含其它jar包，这个时候，就需要在MANIFEST.MF文件里配置classpath了。
#
#    在大型项目中，不可能手动编写MANIFEST.MF文件，再手动创建zip包。Java社区提供了大量的开源构建工具，例如Maven，可以非常方便地创建jar包。


