#!/usr/bin/env bash


# 20190906: 一文看懂 JVM 内存布局及 GC 原理
# https://www.infoq.cn/article/3WyReTKqrHIvtw4frmr3
# https://juejin.im/post/5a15be736fb9a044fc4464d6


# idea install plugin : VisualVM

# https://www.oracle.com/java/technologies/javase/vmoptions-jsp.html
### edit Help -> Edit Custom VM Options... : Append
#    -verbose:gc ： 开启gc日志
#    -XX:+PrintGCDetails ： 打印gc详情
#    -XX:+PrintGCDateStamps ： 打印gc时间戳
#    -Xloggc:gcc.log ： 将日志输出到文件xx(默认位置为桌面)
# e.g.
-verbose:gc
-XX:+PrintGCDetails
-XX:+PrintGCDateStamps
-Xloggc:D:/temp/gc.log


D:/temp/gc.log > http://gceasy.io/

