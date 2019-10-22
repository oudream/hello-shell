#!/bin/bash

#    Shell 截取文件名和后缀 | Cloud's Blog
# http://zuyunfei.com/2016/03/23/Shell-Truncate-File-Extension/
# 
# 
# Shell 截取文件名和后缀
# 截取文件名和后缀
# 编写Shell脚本的过程中，经常会和文件名和文件路径打交道。如果用户输入了一个文件的全名（可能包含绝对路径和文件后缀），如何得到文件的路径名，文件名，文件后缀这些信息呢。Shell脚本拥有强大的字符串处理能力，如果把文件名当做字符串，我们不难使用cut或sed这样的工具得到我们想要的结果。
# 
# $fullfile=/the/path/foo.txt
# $fullname=$(basename $fullfile)
# $dir=$(dirname $fullfile)
# $filename=$(echo $fullname | cut -d . -f1)
# $extension=$(echo $fullname | cut -d . -f2)
# $ echo $dir , $fullname , $filename , $extension
# /the/path , foo.txt , foo , txt
# 这里使用basename命令可以直接得到包含后缀的文件名，而dirname命令可以得到路径名，然后就能简单的用cut截取文件名和后缀名。
# 
# 更复杂的情况
# 如果对付简单应用场景，到这里已经可以打完收工了，但是有时候文件可能不止有一个后缀，比如*.tar.gz，怎样得到最后一个后缀呢？再cut一回？当然可以，但是如果文件名是mylib.1.0.1a.zip这样的呢？呃……正则表达式肯定可以。
# 
# $fullname=mylib.1.0.1a.zip
# $filename=$(echo $fullname | sed 's/\.[^.]*$//')
# $extension=$(echo $fullname | sed 's/^.*\.//')
# $echo $filename, $extension
# mylib.1.0.1a, zip
# 这里面的逻辑是这样的：
# 
# 文件名：把以.字符开头以后一直到行尾都是非.字符的子串替换为空。
# 后缀名：把从行首开始以.字符结尾的子串替换为空。
# 光用语言把这两个正则表达式描述出来脑细胞也要死不少。有没有像上面cut版本一样简单容易理解的方法呢？由于.分隔符的个数不确定，正常使用cut来分割最后一个.字符是不太可能的。但是我们可使用 rev 命令将字符串反转一下，区分后缀和文件名的.字符位置就确定了。截取了想要的部分之后，再次反转就得到了我们想要的内容。
# 
# $fullname=mylib.1.0.1a.zip
# $filename=$(rev <<< $fullname | cut -d . -f2- | rev)
# $extension=$(rev <<< $fullname | cut -d . -f1 | rev)
# $echo $filename, $extension
# mylib.1.0.1a, zip
# 使用参数扩展
# 其实不借助复杂的正则表达式，甚至不调用basename, dirname, cut, sed命令，shell脚本一样可以做到所有的操作。看下面的实现：
# 
# $fullfile=/the/path/mylib.1.0.1a.zip
# $fullname="${fullfile##*/}"
# $dir="${fullfile%/*}"
# $extension="${fullname##*.}"
# $filename="${fullname%.*}"
# $echo $dir , $fullname , $filename , $extension
# /the/path , mylib.1.0.1a.zip , mylib.1.0.1a , zip
# 真是不能再简洁了，大括号之内变量名配合几个神奇的字符，就是Shell的参数扩展(Parameter Extension)功能。
# 
# ${fullfile##*/}：从前面开始删除fullfile中最大匹配(longest matching pattern) */ 的字符串
# ${fullfile%/*}：从后面开始删除fullfile中最小匹配(shortest matching pattern) /* 的字符串
# ${fullname##*.}：从前面开始删除fullname中最大匹配(longest matching pattern) *. 的字符串
# ${fullname%.*}：从后面开始删除fullname中最小匹配(shortest matching pattern) .* 的字符串
# 参数扩展有多种形式，在shell编程中可以用作参数的拼接，字符串的替换，参数列表截取，变量初值等操作，这里不再详述，请参考后面的功能列表和官方文档
# 
# 参数扩展功能列表
# 参数形式	扩展后
# x{y,z}	xy xz
# ${x}{y, z}	${x}y ${x}z
# ${x}{y, $z}	${x}y ${x}${z}
# ${param#pattern}	从param前面删除pattern的最小匹配
# ${param##pattern}	从param前面删除pattern的最大匹配
# ${param%pattern}	从param后面删除pattern的最小匹配
# ${param%%pattern}	从param后面删除pattern的最大匹配
# ${param/pattern/string}	从param中用string替换pattern的第一次匹配，string可为空
# ${param//pattern/string}	从param中用string替换pattern的所有匹配，string可为空
# ${param:3:2}	截取$param中索引3开始的2个字符
# ${param:3}	截取$param中索引3至末尾的字符
# ${@:3:2}	截取参数列表$@中第3个开始的2个参数
# ${param:-word}	若$param为空或未设置，则参数式返回word，$param不变
# ${param:+word}	若$param为非空，则参数式返回word，$param不变
# ${param:=word}	若$param为空或为设置，则参数式返回word，同时$param设置为word
# ${param:?message}	若$param为空或为设置，则输出错误信息message，若包含空白符，则需引号

function testFileName1(){
    fullfile=/the/path/mylib.1.0.1a.zip
    fullname="${fullfile##*/}"
    dir="${fullfile%/*}"
    extension="${fullname##*.}"
    filename="${fullname%.*}"
    echo $dir , $fullname , $filename , $extension
}

echo "-----testFileName1 begin-----"
testFileName1
echo "-----testFileName1 end-----"


