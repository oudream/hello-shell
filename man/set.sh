### 回显设置
set -v
set +v # 使用 + 而不是 - 会使标志位被关闭

set [--abefhkmnptuvxBCHP] [-o 选项名] [--] [参数 ...]
#    设定或取消设定 shell 选项和位置参数的值。
#    改变 shell 选项和位置参数的值，或者显示 shell 变量的名称和值。
#    选项：
#      -a  标记修改的或者创建的变量为导出。
#      -b  立即通告任务终结。
#      -e  如果一个命令以非零状态退出，则立即退出。
#      -f  禁用文件名生成(模式匹配)。
#      -h  当查询命令时记住它们的位置
#      -k  所有的赋值参数被放在命令的环境中，而不仅仅是
#          命令名称之前的参数。
#      -m  启用任务控制。
#      -n  读取命令但不执行
#      -p  无论何时当真实的有效的用户身份不匹配时打开。
#          禁用对 $ENV 文件的处理以及导入 shell 函数。
#          关闭此选项会导致有效的用户编号和组编号设定
#          为真实的用户编号和组编号
#      -t  读取并执行一个命令之后退出。
#      -u  替换时将为设定的变量当作错误对待。
#      -v  读取 shell 输入行时将它们打印。
#      -x  执行命令时打印它们以及参数。
#      -B  shell 将执行花括号扩展。
#      -C  设定之后禁止以重定向输出的方式覆盖常
#          规文件。
#      -E  设定之后 ERR 陷阱会被 shell 函数继承。
#      -H  启用 ! 风格的历史替换。当 shell 是交互式的
#          时候这个标识位默认打开。
#      -P  设定之后类似 cd 的会改变当前目录的命令不
#          追踪符号链接。
#      -T  设定之后 DEBUG 陷阱会被 shell 函数继承。
#      --  任何剩余的参数会被赋值给位置参数。如果没
#          有剩余的参数，位置参数不会被设置。
#      -   任何剩余的参数会被赋值给位置参数。
#          -x 和 -v 选项已关闭。
#
#    使用 + 而不是 - 会使标志位被关闭。标志位也可以在
#    shell 被启动时使用。当前的标志位设定可以在 $- 变
#    量中找到。剩余的 ARG 参数是位置参数并且是按照
#    $1, $2, .. $n 的顺序被赋值的。如果没有给定 ARG
#    参数，则打印所有的 shell 变量。