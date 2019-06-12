#! /usr/bin/sed -f
#
# The Towers Of Hanoi
# sed
# Copyright (C) 2001 Amit Singh. All Rights Reserved.
# http://hanoi.kernelthread.com
#
# usage: 
#   echo xx* | sed -f hanoi.sed
# use N 'x's for N disks, for example:
#   echo xxx | sed -f hanoi.sed will solve for 3 disks
#

:M
s/^xx*$/:n:3:2:1:&:/g
t B
a\
usage: echo xx* | sed -f hanoi.sed. For example, xxx represents 3 disks.
d
:B
/^:$/ { d;q; }
h;s/^:[yn]:\([123]\):[123]:\([123]\):x*:.*/\2 --> \1/g;x
/^:y:[123]:[123]:[123]:x*:.*$/b ~0
/^:n:[123]:[123]:[123]:x:.*/b 1
s/:n:\([123]\):\([123]\):\([123]\):x\(x*\):\(.*\)/:n:\2:\1:\3:\4:y:\1:\2:\3:x\4:\5/g
b B 
:1
x;p;x
s/^:n:[123]:[123]:[123]:x:\(.*\)/:\1/g
b B
:~0
x;p;x
s/^:y:\([123]\):\([123]\):\([123]\):x\(x*\):\(.*\)$/:n:\1:\3:\2:\4:\5/g
b B
:E