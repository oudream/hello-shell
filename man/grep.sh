#!/usr/bin/env bash

grep "main()" . -r --include *.{php,html}

grep -E "[1-9]+"


# 在多个文件中查找：
grep "match_pattern" file_1 file_2 file_3 ...

# 输出除之外的所有行 -v 选项：
grep -v "match_pattern" file_name

# 标记匹配颜色 --color=auto 选项：
grep "match_pattern" file_name --color=auto

# 使用正则表达式 -E 选项：
grep -E "[1-9]+"
# 或
egrep "[1-9]+"

# 使用正则表达式 -P 选项：
grep -P "(\d{3}\-){2}\d{4}" file_name

# 只输出文件中匹配到的部分 -o 选项：
echo this is a test line. | grep -o -E "[a-z]+\." line.
echo this is a test line. | egrep -o "[a-z]+\."  line.

# 统计文件或者文本中包含匹配字符串的行数 -c 选项：
grep -c "text" file_name

# 输出包含匹配字符串的行数 -n 选项：
grep "text" -n file_name
# 或
cat file_name | grep "text" -n

# 多个文件
grep "text" -n file_1 file_2

# 打印样式匹配所位于的字符或字节偏移：
echo gun is not unix | grep -b -o "not"

# 一行中字符串的字符便宜是从该行的第一个字符开始计算，起始值为0。选项  **-b -o**  一般总是配合使用。

# 搜索多个文件并查找匹配文本在哪些文件中：
grep -l "text" file1 file2 file3...


# 在多级目录中对文本进行递归搜索：
grep "text" . -r -n
# .表示当前目录。

# 忽略匹配样式中的字符大小写：
echo "hello world" | grep -i "HELLO"
# hello

# 选项 -e 制动多个匹配样式：
echo this is a text line | grep -e "is" -e "line" -o
#is
#line

#也可以使用 **-f** 选项来匹配多个样式，在样式文件中逐行写出需要匹配的字符。
cat patfile
aaa
bbb

echo aaa bbb ccc ddd eee | grep -f patfile -o

# 在grep搜索结果中包括或者排除指定文件：
# 只在目录中所有的.php和.html文件中递归搜索字符"main()"
grep "main()" . -r --include *.{php,html}
# 在搜索结果中排除所有README文件
grep "main()" . -r --exclude "README"
# 在搜索结果中排除filelist文件列表里的文件
grep "main()" . -r --exclude-from filelist




Usage: grep [OPTION]... PATTERN [FILE]...
Search for PATTERN in each FILE.
Example: grep -i 'hello world' menu.h main.c

Pattern selection and interpretation:
  -E, --extended-regexp     PATTERN is an extended regular expression
  -F, --fixed-strings       PATTERN is a set of newline-separated strings
  -G, --basic-regexp        PATTERN is a basic regular expression (default)
  -P, --perl-regexp         PATTERN is a Perl regular expression
  -e, --regexp=PATTERN      use PATTERN for matching
  -f, --file=FILE           obtain PATTERN from FILE
  -i, --ignore-case         ignore case distinctions
  -w, --word-regexp         force PATTERN to match only whole words
  -x, --line-regexp         force PATTERN to match only whole lines
  -z, --null-data           a data line ends in 0 byte, not newline

Miscellaneous:
  -s, --no-messages         suppress error messages
  -v, --invert-match        select non-matching lines
  -V, --version             display version information and exit
      --help                display this help text and exit

Output control:
  -m, --max-count=NUM       stop after NUM selected lines
  -b, --byte-offset         print the byte offset with output lines
  -n, --line-number         print line number with output lines
      --line-buffered       flush output on every line
  -H, --with-filename       print file name with output lines
  -h, --no-filename         suppress the file name prefix on output
      --label=LABEL         use LABEL as the standard input file name prefix
  -o, --only-matching       show only the part of a line matching PATTERN
  -q, --quiet, --silent     suppress all normal output
      --binary-files=TYPE   assume that binary files are TYPE;
                            TYPE is 'binary', 'text', or 'without-match'
  -a, --text                equivalent to --binary-files=text
  -I                        equivalent to --binary-files=without-match
  -d, --directories=ACTION  how to handle directories;
                            ACTION is 'read', 'recurse', or 'skip'
  -D, --devices=ACTION      how to handle devices, FIFOs and sockets;
                            ACTION is 'read' or 'skip'
  -r, --recursive           like --directories=recurse
  -R, --dereference-recursive  likewise, but follow all symlinks
      --include=FILE_PATTERN  search only files that match FILE_PATTERN
      --exclude=FILE_PATTERN  skip files and directories matching FILE_PATTERN
      --exclude-from=FILE   skip files matching any file pattern from FILE
      --exclude-dir=PATTERN  directories that match PATTERN will be skipped.
  -L, --files-without-match  print only names of FILEs with no selected lines
  -l, --files-with-matches  print only names of FILEs with selected lines
  -c, --count               print only a count of selected lines per FILE
  -T, --initial-tab         make tabs line up (if needed)
  -Z, --null                print 0 byte after FILE name

Context control:
  -B, --before-context=NUM  print NUM lines of leading context
  -A, --after-context=NUM   print NUM lines of trailing context
  -C, --context=NUM         print NUM lines of output context
  -NUM                      same as --context=NUM
      --color[=WHEN],
      --colour[=WHEN]       use markers to highlight the matching strings;
                            WHEN is 'always', 'never', or 'auto'
  -U, --binary              do not strip CR characters at EOL (MSDOS/Windows)

When FILE is '-', read standard input.  With no FILE, read '.' if
recursive, '-' otherwise.  With fewer than two FILEs, assume -h.
Exit status is 0 if any line is selected, 1 otherwise;
if any error occurs and -q is not given, the exit status is 2.

Report bugs to: bug-grep@gnu.org
GNU grep home page: <http://www.gnu.org/software/grep/>
General help using GNU software: <http://www.gnu.org/gethelp/>