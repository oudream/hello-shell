# Linux下JSON文本处理工具jq
# 一、Overviews

jq 是一款命令行下处理 JSON 数据的工具。其可以接收标准输入，命令管道或者文件中的 JSON 数据，经过一系列的过滤器(filters)和表达式的转后形成我们需要的数据结构并将结果输出到标准输出中。jq 的这种特性使我们可以很容易地在 Shell 脚本中调用它。

# 二、安装

```bash
yum install -y epel-release ;\
yum install -y jq
```

# 三、jq命令参数

```bash
jq [options] <jq filter> [file...]

options:
  -c             使输出紧凑，而不是把每一个JSON对象输出在一行。;
  -n             不读取任何输入，过滤器运行使用null作为输入。一般用作从头构建JSON数据。;
  -e             set the exit status code based on the output;
  -s             读入整个输入流到一个数组(支持过滤);
  -r             如果过滤的结果是一个字符串，那么直接写到标准输出（去掉字符串的引号）;
  -R             read raw strings, not JSON texts;
  -C             打开颜色显示;
  -M             关闭颜色显示;
  -S             sort keys of objects on output;
  --tab          use tabs for indentation;
  --arg a v      jq 通过该选项提供了和宿主脚本语言交互的能力。该选项将值(v)绑定到一个变量(a)上。在后面的 filter 中可以直接通过变量引用这个值。例如，filter '.$a'表示查询属性名称等于变量 a 的值的属性。;
  --argjson a v  set variable $a to JSON value <v>;
  --slurpfile a f set variable $a to an array of JSON texts read from <f>;
```

# 参考链接

1. https://www.ibm.com/developerworks/cn/linux/1612_chengg_jq/index.html?ca=drs-&utm_source=tuicool&utm_medium=referral