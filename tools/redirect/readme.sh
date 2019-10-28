#!/usr/bin/env bash

# https://www.isi.edu/~yuri/dupx/dupx_man.html
# https://stackoverflow.com/questions/1323956/how-to-redirect-output-of-an-already-running-process/3560510

### dupx install
cd dupx
./configure; make; make install

# SYNOPSIS
dupx/dupx [-q] [-o ofile] [-e efile] [-i ifile]
# [-n fd:filename] <pid>
# dupx [-q] <pid>

# DESCRIPTION
# Dupx is a simple utility to remap files of an already running program. Shells like Bash allow easy input/output/error redirection at the time the program is started using >, < - like syntax, e.g.:
# echo 'redirect this text' > /tmp/stdout
# will redirect output of echo to /tmp/stdout.
# Standard shells however do not provide the capability of remapping (redirecting) of output (or input, or error) for an already started process. Dupx tries to address this problem by using dup(2) system call from inside gdb(1). Dupx is currently implemented as a simple shell wrapper around a gdb script.


# OPTIONS
# In the first form of its invocation, the user can optionally specify where he wants input/output/error to be using:
# -o ofile
# redirects the remaining of standard output (assumed to correspond to file descriptor 0) to the filename ofile. This file is opened in write-only, append-to mode. It's created if it does not already exist.
# -i ifile
# redirects the remaining of standard input (assumed to correspond to file descriptor 1) to the filename ifile. This file is opened in read-only mode.
# -e efile
# redirects the remaining of standard error (assumed to correspond to file descriptor 2) to the filename efile. This file is opened in write-only, append-to mode. It's created if it does not already exist.
# -n fd:filename
# remaps the file descriptor fd to the filename. This file is opened in read-write, append-to mode. It's created if it does not already exist. This option can be specified multiple times for different descriptors.
# -q
# Be as quiet as possible.
# In the second form of its invocation, dupx remaps the standard input, output, and error from the current command line into the process specified by pidR.


# EXAMPLE USAGE
# Note that these examples use bash syntax. First, we start a background bash job that sleeps, then prints something on standard output:
bash -c 'sleep 1m && echo rise and shine' &
# 1. Redirect the remainder of standard output to /tmp/stdout
# The following invocations are equivalent:
dupx/dupx -n 0:/tmp/test $!
dupx/dupx -o /tmp/test $!
dupx/dupx $! >>/tmp/test

# Note that the last example also remaps stderr and stdin of the process. But because the target process was started on the same tty as dupx is being run, they are effectively unchanged.
# 2. Redirect the remainder of stdout, and stderr to different files, read the rest of stdin from /dev/null:
# The following invocations are equivalent:
dupx/dupx -o /tmp/stdout -e /tmp/stderr -i /dev/null $!
dupx/dupx -n 0:/tmp/stdout 1:/dev/null 2:/tmp/stderr $!
dupx/dupx >/tmp/stdout 2>/tmp/stderr </dev/null $!

dupx/dupx -o /root/foo3 -e /root/foo3 -i /dev/null $!



### reredirect redirect relink
# https://github.com/jerome-pouiller/reredirect
git clone https://github.com/oudream/reredirect
cd reredirect
make install
# man
reredirect [-m FILE|-o FILE|-e FILE|-O FD|-E FD] [-N] [-d] PID
# redirect outputs of a running process to a file
# PID      Process to reattach\n");
# -o FILE  File to redirect stdout. \n");
# -e FILE  File to redirect stderr.\n");
# -m FILE  Same than -o FILE -e FILE.\n");
# -O FD    Redirect stdout to this file descriptor. Mainly used to restore\n");
#          process outputs.\n");
# -E FD    Redirect stderr to this file descriptor. Mainly used to restore\n");
#          process outputs.\n");
reredirect -o /root/foo1 -e /root/foo3 22465
reredirect -N -O 5 -E 3 22465
