
### 
- https://phenix3443.github.io/notebook/software-engineering/debug/valgrind-practices.html

### 内存问题
```text
使用未初始化的内存
读/写已经被释放的内存
读/写内存越界
读/写不恰当的内存栈空间
内存泄漏
使用 malloc/new/new[] 和 free/delete/delete[] 不匹配。
src 和 dst 的重叠
```

### 这里是测试的一个C程序例子
```c
#include <stdlib.h>
#include <stdio.h>
void func()
{
 //只申请内存而不释放
    void *p=malloc(sizeof(int));
}
int main()
{
    func();
    getchar();
    return 0;
}
```
```shell
gcc -o ./a.out ./main.c
valgrind --log-file=valReport --leak-check=full --show-reachable=yes --leak-resolution=low ./a.out
```
```text
–log-file=valReport 是指定生成分析日志文件到当前执行目录中，文件名为valReport
–leak-check=full 显示每个泄露的详细信息
–show-reachable=yes 是否检测控制范围之外的泄漏，比如全局指针、static指针等，显示所有的内存泄露类型
–leak-resolution=low 内存泄漏报告合并等级
```


### install setup
```shell

### install ubuntu
sudo apt-get install valgrind check

### install centos
sudo yum install valgrind

```


### 常用
```shell
# 最常用的选项。运行 valgrind 中名为 toolname 的工具。默认 memcheck。
--tool=<name> 
    Memcheck   # 用于检测内存错误。它帮助c和c++的程序更正确。
    Cachegrind # 用于分析cache和分支预测。它帮助程序执行得更快。
    Callgrind  # 用于函数调用的分析。
    Helgrind   # 用于分析多线程。
    DRD        # 也用于分析多线程。与Helgrind类似，但是用不同的分析技术，所以可以检测不同的问题。
    Massif     # 用于分析堆。它帮助程序精简内存的使用。
    SGcheck    # 检测栈和全局数组溢出的实验性工具，它和Memcheck互补使用。

# 显示所有选项的帮助，包括内核和选定的工具两者。
-h --help

# 显示 valgrind 内核的版本，每个工具都有各自的版本。
--version

# 安静地运行，只打印错误信息。
-q --quiet

# 更详细的信息。
--verbose

# 跟踪子线程? [default: no]
--trace-children=<yes|no>

# 跟踪打开的文件描述？ [default: no]
--track-fds=<yes|no>

# 增加时间戳到 LOG 信息? [default: no]
--time-stamp=<yes|no>

# 输出 LOG 到描述符文件 [2=stderr]
--log-fd=<number>

# 将输出的信息写入到 filename.PID 的文件里，PID 是运行程序的进行 ID
--log-file=<file>

# 输出 LOG 信息到 file,LOG 信息输出
--log-file-exactly=<file>

# 将信息以 xml 格式输出，只有 memcheck 可用
--xml=yes

# show <number> callers in stack traces
--num-callers=<number>

# 如果发现错误则返回错误代码 [0=disable]
--error-exitcode=<number>

# 当出现错误，valgrind 会自动启动调试器 gdb。[default: no]
--db-attach=<yes|no>

# 启动调试器的命令行选项[gdb -nw %f %p]
--db-command=<command>
```


### help
- usage: valgrind [options] prog-and-args
```shell
  tool-selection option, with default in [ ]:
    --tool=<name>             use the Valgrind tool named <name> [memcheck]

  basic user options for all Valgrind tools, with defaults in [ ]:
    -h --help                 show this message
    --help-debug              show this message, plus debugging options
    --version                 show version
    -q --quiet                run silently; only print error msgs
    -v --verbose              be more verbose -- show misc extra info
    --trace-children=no|yes   Valgrind-ise child processes (follow execve)? [no]
    --trace-children-skip=patt1,patt2,...    specifies a list of executables
                              that --trace-children=yes should not trace into
    --trace-children-skip-by-arg=patt1,patt2,...   same as --trace-children-skip=
                              but check the argv[] entries for children, rather
                              than the exe name, to make a follow/no-follow decision
    --child-silent-after-fork=no|yes omit child output between fork & exec? [no]
    --vgdb=no|yes|full        activate gdbserver? [yes]
                              full is slower but provides precise watchpoint/step
    --vgdb-error=<number>     invoke gdbserver after <number> errors [999999999]
                              to get started quickly, use --vgdb-error=0
                              and follow the on-screen directions
    --vgdb-stop-at=event1,event2,... invoke gdbserver for given events [none]
         where event is one of:
           startup exit valgrindabexit all none
    --track-fds=no|yes        track open file descriptors? [no]
    --time-stamp=no|yes       add timestamps to log messages? [no]
    --log-fd=<number>         log messages to file descriptor [2=stderr]
    --log-file=<file>         log messages to <file>
    --log-socket=ipaddr:port  log messages to socket ipaddr:port

  user options for Valgrind tools that report errors:
    --xml=yes                 emit error output in XML (some tools only)
    --xml-fd=<number>         XML output to file descriptor
    --xml-file=<file>         XML output to <file>
    --xml-socket=ipaddr:port  XML output to socket ipaddr:port
    --xml-user-comment=STR    copy STR verbatim into XML output
    --demangle=no|yes         automatically demangle C++ names? [yes]
    --num-callers=<number>    show <number> callers in stack traces [12]
    --error-limit=no|yes      stop showing new errors if too many? [yes]
    --error-exitcode=<number> exit code to return if errors found [0=disable]
    --error-markers=<begin>,<end> add lines with begin/end markers before/after
                              each error output in plain text mode [none]
    --show-below-main=no|yes  continue stack traces below main() [no]
    --default-suppressions=yes|no
                              load default suppressions [yes]
    --suppressions=<filename> suppress errors described in <filename>
    --gen-suppressions=no|yes|all    print suppressions for errors? [no]
    --input-fd=<number>       file descriptor for input [0=stdin]
    --dsymutil=no|yes         run dsymutil on Mac OS X when helpful? [yes]
    --max-stackframe=<number> assume stack switch for SP changes larger
                              than <number> bytes [2000000]
    --main-stacksize=<number> set size of main thread's stack (in bytes)
                              [min(max(current 'ulimit' value,1MB),16MB)]

  user options for Valgrind tools that replace malloc:
    --alignment=<number>      set minimum alignment of heap allocations [16]
    --redzone-size=<number>   set minimum size of redzones added before/after
                              heap blocks (in bytes). [16]
    --xtree-memory=none|allocs|full   profile heap memory in an xtree [none]
                              and produces a report at the end of the execution
                              none: no profiling, allocs: current allocated
                              size/blocks, full: profile current and cumulative
                              allocated size/blocks and freed size/blocks.
    --xtree-memory-file=<file>   xtree memory report file [xtmemory.kcg.%p]

  uncommon user options for all Valgrind tools:
    --fullpath-after=         (with nothing after the '=')
                              show full source paths in call stacks
    --fullpath-after=string   like --fullpath-after=, but only show the
                              part of the path after 'string'.  Allows removal
                              of path prefixes.  Use this flag multiple times
                              to specify a set of prefixes to remove.
    --extra-debuginfo-path=path    absolute path to search for additional
                              debug symbols, in addition to existing default
                              well known search paths.
    --debuginfo-server=ipaddr:port    also query this server
                              (valgrind-di-server) for debug symbols
    --allow-mismatched-debuginfo=no|yes  [no]
                              for the above two flags only, accept debuginfo
                              objects that don't "match" the main object
    --smc-check=none|stack|all|all-non-file [all-non-file]
                              checks for self-modifying code: none, only for
                              code found in stacks, for all code, or for all
                              code except that from file-backed mappings
    --read-inline-info=yes|no read debug info about inlined function calls
                              and use it to do better stack traces.  [yes]
                              on Linux/Android/Solaris for Memcheck/Helgrind/DRD
                              only.  [no] for all other tools and platforms.
    --read-var-info=yes|no    read debug info on stack and global variables
                              and use it to print better error messages in
                              tools that make use of it (Memcheck, Helgrind,
                              DRD) [no]
    --vgdb-poll=<number>      gdbserver poll max every <number> basic blocks [5000]
    --vgdb-shadow-registers=no|yes   let gdb see the shadow registers [no]
    --vgdb-prefix=<prefix>    prefix for vgdb FIFOs [/tmp/vgdb-pipe]
    --run-libc-freeres=no|yes free up glibc memory at exit on Linux? [yes]
    --run-cxx-freeres=no|yes  free up libstdc++ memory at exit on Linux
                              and Solaris? [yes]
    --sim-hints=hint1,hint2,...  activate unusual sim behaviours [none]
         where hint is one of:
           lax-ioctls lax-doors fuse-compatible enable-outer
           no-inner-prefix no-nptl-pthread-stackcache fallback-llsc none
    --fair-sched=no|yes|try   schedule threads fairly on multicore systems [no]
    --kernel-variant=variant1,variant2,...
         handle non-standard kernel variants [none]
         where variant is one of:
           bproc android-no-hw-tls
           android-gpu-sgx5xx android-gpu-adreno3xx none
    --merge-recursive-frames=<number>  merge frames between identical
           program counters in max <number> frames) [0]
    --num-transtab-sectors=<number> size of translated code cache [32]
           more sectors may increase performance, but use more memory.
    --avg-transtab-entry-size=<number> avg size in bytes of a translated
           basic block [0, meaning use tool provided default]
    --aspace-minaddr=0xPP     avoid mapping memory below 0xPP [guessed]
    --valgrind-stacksize=<number> size of valgrind (host) thread's stack
                               (in bytes) [1048576]
    --show-emwarns=no|yes     show warnings about emulation limits? [no]
    --require-text-symbol=:sonamepattern:symbolpattern    abort run if the
                              stated shared object doesn't have the stated
                              text symbol.  Patterns can contain ? and *.
    --soname-synonyms=syn1=pattern1,syn2=pattern2,... synonym soname
              specify patterns for function wrapping or replacement.
              To use a non-libc malloc library that is
                  in the main exe:  --soname-synonyms=somalloc=NONE
                  in libxyzzy.so:   --soname-synonyms=somalloc=libxyzzy.so
    --sigill-diagnostics=yes|no  warn about illegal instructions? [yes]
    --unw-stack-scan-thresh=<number>   Enable stack-scan unwind if fewer
                  than <number> good frames found  [0, meaning "disabled"]
                  NOTE: stack scanning is only available on arm-linux.
    --unw-stack-scan-frames=<number>   Max number of frames that can be
                  recovered by stack scanning [5]
    --resync-filter=no|yes|verbose [yes on MacOS, no on other OSes]
              attempt to avoid expensive address-space-resync operations
    --max-threads=<number>    maximum number of threads that valgrind can
                              handle [500]

  user options for Memcheck:
    --leak-check=no|summary|full     search for memory leaks at exit?  [summary]
    --leak-resolution=low|med|high   differentiation of leak stack traces [high]
    --show-leak-kinds=kind1,kind2,.. which leak kinds to show?
                                            [definite,possible]
    --errors-for-leak-kinds=kind1,kind2,..  which leak kinds are errors?
                                            [definite,possible]
        where kind is one of:
          definite indirect possible reachable all none
    --leak-check-heuristics=heur1,heur2,... which heuristics to use for
        improving leak search false positive [all]
        where heur is one of:
          stdstring length64 newarray multipleinheritance all none
    --show-reachable=yes             same as --show-leak-kinds=all
    --show-reachable=no --show-possibly-lost=yes
                                     same as --show-leak-kinds=definite,possible
    --show-reachable=no --show-possibly-lost=no
                                     same as --show-leak-kinds=definite
    --xtree-leak=no|yes              output leak result in xtree format? [no]
    --xtree-leak-file=<file>         xtree leak report file [xtleak.kcg.%p]
    --undef-value-errors=no|yes      check for undefined value errors [yes]
    --track-origins=no|yes           show origins of undefined values? [no]
    --partial-loads-ok=no|yes        too hard to explain here; see manual [yes]
    --expensive-definedness-checks=no|yes
                                     Use extra-precise definedness tracking [no]
    --freelist-vol=<number>          volume of freed blocks queue     [20000000]
    --freelist-big-blocks=<number>   releases first blocks with size>= [1000000]
    --workaround-gcc296-bugs=no|yes  self explanatory [no].  Deprecated.
                                     Use --ignore-range-below-sp instead.
    --ignore-ranges=0xPP-0xQQ[,0xRR-0xSS]   assume given addresses are OK
    --ignore-range-below-sp=<number>-<number>  do not report errors for
                                     accesses at the given offsets below SP
    --malloc-fill=<hexnumber>        fill malloc'd areas with given value
    --free-fill=<hexnumber>          fill free'd areas with given value
    --keep-stacktraces=alloc|free|alloc-and-free|alloc-then-free|none
        stack trace(s) to keep for malloc'd/free'd areas       [alloc-and-free]
    --show-mismatched-frees=no|yes   show frees that don't match the allocator? [yes]

  Extra options read from ~/.valgrindrc, $VALGRIND_OPTS, ./.valgrindrc

  Memcheck is Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
  Valgrind is Copyright (C) 2000-2017, and GNU GPL'd, by Julian Seward et al.
  LibVEX is Copyright (C) 2004-2017, and GNU GPL'd, by OpenWorks LLP et al.

  Bug reports, feedback, admiration, abuse, etc, to: www.valgrind.org.

```
