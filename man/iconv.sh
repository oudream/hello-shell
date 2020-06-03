#!/usr/bin/env bash

# 递归转换(包括子文件夹)
# 这两行命令将default目录下的文件由GBK编码转换为UTF-8编码，目录结构不变，转码后的文件保存在utf/default目录下。
find default -type d -exec mkdir -p utf/{} \;
find default -type f -exec iconv -f GBK -t UTF-8 {} -o utf/{} \;
# 注意：如果原来就是utf-8编码，使用iconv -f GBK -t UTF-8命令转换后，会出现乱码，或截断等各种问题；一定要保证原文件是不是utf-8编码；

#    -c : 静默丢弃不能识别的字符，而不是终止转换。
#    -f,--from-code=[encoding]:指定待转换文件的编码。
#    -t,--to-code=[encoding]:指定目标编码。
#    -l,--list:列出已知的字符编码。
#    -o,--output=[file] :列出指定输出文件，而非默认输出到标准输出。
#    -s,--silent：关闭警告。
#    --verbose:显示进度信息。
#    -?, --help:显示帮助信息。
#    --usage：显示简要使用方法。
#    -V,--version:显示版本信息。
