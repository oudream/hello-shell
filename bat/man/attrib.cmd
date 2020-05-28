Microsoft Windows [版本 6.1.7601]
版权所有 (c) 2009 Microsoft Corporation。保留所有权利。

C:\Users\oudream>attrib /?
显示或更改文件属性。

ATTRIB [+R | -R] [+A | -A ] [+S | -S] [+H | -H] [+I | -I]
       [drive:][path][filename] [/S [/D] [/L]]
  + 设置属性。
  - 清除属性。
  R 只读文件属性。
  A 存档文件属性。
  S 系统文件属性。
  H 隐藏文件属性。
  I 无内容索引文件属性。
  [drive:][path][filename]
      指定 attrib 要处理的文件。
  /S 处理当前文件夹及其所有子文件夹中的匹配文件。
  /D 也处理文件夹。
  /L 处理符号链接和符号链接目标的属性。


C:\Users\oudream>cd /d F:\cygwin\etc\alternatives

F:\cygwin\etc\alternatives>dir /a
 驱动器 F 中的卷是 AAAFFF
 卷的序列号是 0CA3-C0EC

 F:\cygwin\etc\alternatives 的目录

2013/03/01  16:15    <DIR>          .
2013/03/01  16:15    <DIR>          ..
2013/03/01  14:55                50 c++
2013/03/01  14:55                48 cc
2013/03/01  14:55                50 cpp
2013/03/01  14:55                74 cpp.1.gz
2013/03/01  14:55                50 g++
2013/03/01  14:55                74 g++.1.gz
2013/03/01  14:55                50 gcc
2013/03/01  14:55                74 gcc.1.gz
2013/03/01  14:55                52 gcov
2013/03/01  14:55                76 gcov.1.gz
2013/03/01  14:55                80 i686-pc-cygwin-c++
2013/03/01  14:55                80 i686-pc-cygwin-g++
2013/03/01  14:55                80 i686-pc-cygwin-gcc
2013/03/01  14:55                60 protoize
2009/04/06  03:30               163 README
2013/03/01  14:55                64 unprotoize
              16 个文件          1,125 字节
               2 个目录 75,727,175,680 可用字节

F:\cygwin\etc\alternatives>dir /?
显示目录中的文件和子目录列表。

DIR [drive:][path][filename] [/A[[:]attributes]] [/B] [/C] [/D] [/L] [/N]
  [/O[[:]sortorder]] [/P] [/Q] [/R] [/S] [/T[[:]timefield]] [/W] [/X] [/4]

  [drive:][path][filename]
              指定要列出的驱动器、目录和/或文件。

  /A          显示具有指定属性的文件。
  属性         D  目录                R  只读文件
               H  隐藏文件            A  准备存档的文件
               S  系统文件            I  无内容索引文件
               L  解析点             -  表示“否”的前缀
  /B          使用空格式(没有标题信息或摘要)。
  /C          在文件大小中显示千位数分隔符。这是默认值。用 /-C 来
              禁用分隔符显示。
  /D          跟宽式相同，但文件是按栏分类列出的。
  /L          用小写。
  /N          新的长列表格式，其中文件名在最右边。
  /O          用分类顺序列出文件。
  排列顺序     N  按名称(字母顺序)     S  按大小(从小到大)
               E  按扩展名(字母顺序)   D  按日期/时间(从先到后)
               G  组目录优先           -  反转顺序的前缀
  /P          在每个信息屏幕后暂停。
  /Q          显示文件所有者。
  /R          显示文件的备用数据流。
  /S          显示指定目录和所有子目录中的文件。
  /T          控制显示或用来分类的时间字符域。
  时间段      C  创建时间
              A  上次访问时间
              W  上次写入的时间
  /W          用宽列表格式。
  /X          显示为非 8.3 文件名产生的短名称。格式是 /N 的格式，
              短名称插在长名称前面。如果没有短名称，在其位置则
              显示空白。
  /4          用四位数字显示年

可以在 DIRCMD 环境变量中预先设定开关。通过添加前缀 - (破折号)
来替代预先设定的开关。例如，/-W。

F:\cygwin\etc\alternatives>dir /a:h
 驱动器 F 中的卷是 AAAFFF
 卷的序列号是 0CA3-C0EC

 F:\cygwin\etc\alternatives 的目录

找不到文件

F:\cygwin\etc\alternatives>dir /a:s
 驱动器 F 中的卷是 AAAFFF
 卷的序列号是 0CA3-C0EC

 F:\cygwin\etc\alternatives 的目录

2013/03/01  14:55                50 c++
2013/03/01  14:55                48 cc
2013/03/01  14:55                50 cpp
2013/03/01  14:55                74 cpp.1.gz
2013/03/01  14:55                50 g++
2013/03/01  14:55                74 g++.1.gz
2013/03/01  14:55                50 gcc
2013/03/01  14:55                74 gcc.1.gz
2013/03/01  14:55                52 gcov
2013/03/01  14:55                76 gcov.1.gz
2013/03/01  14:55                80 i686-pc-cygwin-c++
2013/03/01  14:55                80 i686-pc-cygwin-g++
2013/03/01  14:55                80 i686-pc-cygwin-gcc
2013/03/01  14:55                60 protoize
2013/03/01  14:55                64 unprotoize
              15 个文件            962 字节
               0 个目录 75,727,175,680 可用字节

F:\cygwin\etc\alternatives>cd /d F:\Tools\Designer\cygwin\etc\alternatives

F:\Tools\Designer\cygwin\etc\alternatives>attrib +s g++

F:\Tools\Designer\cygwin\etc\alternatives>dir /a:s
 驱动器 F 中的卷是 AAAFFF
 卷的序列号是 0CA3-C0EC

 F:\Tools\Designer\cygwin\etc\alternatives 的目录

2012/04/19  20:17                50 g++
               1 个文件             50 字节
               0 个目录 75,727,175,680 可用字节

F:\Tools\Designer\cygwin\etc\alternatives>dir /a:s