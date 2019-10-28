#!/usr/bin/env bash


cut [option][n-n] filepath1|pipe

### 按输入的一行一行来处理
## option
# -b ：输入每行第n个字符（半角，注意如果有中文将乱码）。
# -c ：输入每行第n个字符（适用中文）。
# -d ：自定义分隔符，默认为制表符。
# -f ：与-d一起使用，指定显示哪个区域。
# -n ：取消分割多字节字符（例如中文）。仅和-b标志一起使用。
## n-n
# 提取范围，
#    如果只有 -n 就表示取 0~n
#    如果只有 n 只取第 n

## e.g.
echo a:b:c:d:e | cut -d":" -f -3
# a:b:c
who|cut -b -7
# oudream
# ...
# oudream
