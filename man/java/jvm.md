
### 一文看懂 JVM 内存布局及 GC 原理
- https://www.infoq.cn/article/3WyReTKqrHIvtw4frmr3
- https://juejin.im/post/5a15be736fb9a044fc4464d6


### idea install plugin : VisualVM
- https://www.oracle.com/java/technologies/javase/vmoptions-jsp.html
> edit Help -> Edit Custom VM Options... : Append  
```shell script
#    -verbose:gc ： 开启gc日志
#    -XX:+PrintGCDetails ： 打印gc详情
#    -XX:+PrintGCDateStamps ： 打印gc时间戳
#    -Xloggc:gcc.log ： 将日志输出到文件xx(默认位置为桌面)

# e.g.
-verbose:gc
-XX:+PrintGCDetails
-XX:+PrintGCDateStamps
-Xloggc:D:/temp/gc.log

# D:/temp/gc.log > http://gceasy.io/
```


### 使用 -XX:+PrintGC 开启简单的 GC 日志。
> 以启动 SpringBoot 为例：
```shell script
#  [GC (Allocation Failure)  262144K->24800K(1005056K), 0.0182439 secs]
#  [GC (Metadata GC Threshold)  45740K->14793K(1005056K), 0.0099653 secs]
#  [Full GC (Metadata GC Threshold)  14793K->14558K(1005056K), 0.0803518 secs]
```
- 开头是 GC 或者 FULL GC，然后是 GC 前和 GC 后使用的堆空间的大小，括号中是堆的大小，最后是 GC 执行耗费的时间。
