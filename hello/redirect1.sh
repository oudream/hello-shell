#!/usr/bin/env bash

###
# https://stackoverflow.com/questions/1323956/how-to-redirect-output-of-an-already-running-process/3560510
###

###
### gdb
###
### (No debugging symbols found in /bin/cat)
### Attaching to program: /bin/cat, process 6627
### ptrace: Operation not permitted.
# See Redirecting Output from a Running Process.
# Firstly I run the command
cat > foo1 &
# in one session and test that data from stdin is copied to the file. Then in another session I redirect the output.
# Firstly find the PID of the process:
ps aux | grep cat
#rjc 6627 0.0 0.0 1580 376 pts/5 S+ 15:31 0:00 cat

# Now check the file handles it has open:
ls -l /proc/6627/fd
# total 3
#lrwx—— 1 rjc rjc 64 Feb 27 15:32 0 -> /dev/pts/5
#l-wx—— 1 rjc rjc 64 Feb 27 15:32 1 -> /tmp/foo1
#lrwx—— 1 rjc rjc 64 Feb 27 15:32 2 -> /dev/pts/5

#Now run GDB:
gdb -p 6627 /bin/cat
# GNU gdb 6.4.90-debian
# [license stuff snipped]
# Attaching to program: /bin/cat, process 6627
# [snip other stuff that's not interesting now]
(gdb) p close(1)
# $1 = 0
(gdb) p creat("/tmp/foo3", 0600)
# $2 = 1
(gdb) q
# The program is running. Quit anyway (and detach it)? (y or n) y
# Detaching from program: /bin/cat, process 6627
ls -l /proc/6627/fd
# total 3
#lrwx—— 1 rjc rjc 64 Feb 27 15:32 0 -> /dev/pts/5
#l-wx—— 1 rjc rjc 64 Feb 27 15:32 1 -> /tmp/foo3
#lrwx—— 1 rjc rjc 64 Feb 27 15:32 2 -> /dev/pts/5
# The p command in GDB will print the value of an expression, an expression can be a function to call,
# it can be a system call… So I execute a close() system call and pass file handle 1,
# then I execute a creat() system call to open a new file. The result of the creat() was 1 which means
# that it replaced the previous file handle. If I wanted to use the same file for stdout and stderr or
# if I wanted to replace a file handle with some other number then I would need to
# call the dup2() system call to achieve that result.

# For this example I chose to use creat() instead of open() because there are fewer parameter.
# The C macros for the flags are not usable from GDB (it doesn’t use C headers) so I would have to read header files
# to discover this – it’s not that hard to do so but would take more time. Note that 0600 is the octal permission for
# the owner having read/write access and the group and others having no access. It would also work to use 0 for
# that parameter and run chmod on the file later on.
# After that I verify the result:
ls -l /proc/6627/fd/
# total 3
#lrwx—— 1 rjc rjc 64 2008-02-27 15:32 0 -> /dev/pts/5
#l-wx—— 1 rjc rjc 64 2008-02-27 15:32 1 -> /tmp/foo3 <====
#lrwx—— 1 rjc rjc 64 2008-02-27 15:32 2 -> /dev/pts/5
#Typing more data in to cat results in the file /tmp/foo3 being appended to.
#
# If you want to close the original session you need to close all file handles for it, open a new device that can be the controlling tty, and then call setsid().



###
### dupx
###
cat > foo1 &
ps aux | grep cat
ls -l /proc/17296/fd
dupx -o /root/foo3 $!
