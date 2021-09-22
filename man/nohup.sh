
nohup /usr/local/ncsearch/search 1> /var/log/ncsearch.log 2>/dev/null &

nohup /usr/local/ncsearch/search 1>> /var/log/ncsearch.log 2>>/dev/null &

nohup Command [ Arg ... ] [ & ]

# 2>&1 解释：
# 将标准错误 2 重定向到标准输出 &1 ，标准输出 &1 再被重定向输入到 runoob.log 文件中。
0 #– stdin (standard input，标准输入)
1 #– stdout (standard output，标准输出)
2 #– stderr (standard error，标准错误输出)

