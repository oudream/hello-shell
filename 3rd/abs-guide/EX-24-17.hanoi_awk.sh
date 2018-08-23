#! /usr/bin/awk -f
#
# The Towers Of Hanoi
# AWK
# Copyright (C) 1998 Amit Singh. All Rights Reserved.
# http://hanoi.kernelthread.com
#
# Tested under GNU Awk (gawk) 3.0.3
#

function moveit(from, to)
{
  print "move", from, "-->", to;
}

function dohanoi(n, to, from, using)
{
  if (n > 0) {
    dohanoi(n-1, using, from, to);
    moveit(from, to);
    dohanoi(n-1, to, using, from);
  }
}

function hanoi(n)
{
  if (n + 0 < 10 && n+0 > 0)
    dohanoi(n, 3, 1, 2)
  else
    print "illegal value for number of disks (max 10)";
}

hanoi($1)
