#!/usr/bin/env bash


cat alpha.log | tee file1 file2 file3 | cat
cat alpha.log | tee file1 file2 file3 >/dev/null


# tee 多重定向
# 利用管道和 tee 命令，该命令可以从标准输入中读入信息并将其写入标准输出或文件中，
echo a |sudo tee 1.txt
echo a |sudo tee -a 1.txt #  -a 是追加的意思，等同于 >>

tee # 命令很好用，它从管道接受信息，一边向屏幕输出，一边向文件写入。

# tee - read from standard input and write to standard output and files
tee [OPTION]... [FILE]...

# DESCRIPTION
Copy standard input to each FILE, and also to standard output.

-a, --append # append to the given FILEs, do not overwrite

-i, --ignore-interrupts # ignore interrupt signals

-p # diagnose errors writing to non pipes

--output-error[=MODE] # set behavior on write error.  See MODE below

--help # display this help and exit

--version # output version information and exit

#MODE determines behavior with write errors on the outputs:
#   'warn' diagnose errors writing to any output
#
#   'warn-nopipe'
#          diagnose errors writing to any output not a pipe
#
#          set behavior on write error.  See MODE below
#
#   --help display this help and exit
#
#   --version
#          output version information and exit
#
#MODE determines behavior with write errors on the outputs:
#   'warn' diagnose errors writing to any output
#
#   'warn-nopipe'
#          diagnose errors writing to any output not a pipe
#
#   'exit' exit on error writing to any output
#
#   'exit-nopipe'
#          exit on error writing to any output not a pipe
#
#   The  default  MODE for the -p option is 'warn-nopipe'.  The default operation when --output-error is not specified, is
#   to exit immediately on error writing to a pipe, and diagnose errors writing to non pipe outputs.