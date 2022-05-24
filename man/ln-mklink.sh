#!/usr/bin/env bash

mklink /D "C:\dev\hello-shell\projects\tk\ZhongShan" "C:\dev\tk\中山"

mklink /D link-dir1(created) "C:\dev\tk\rknn"

ln -s /ddd/dir1 link-dir1(created) # create real-dir link-dir1

# ln
ln [OPTION]... [-T] TARGET LINK_NAME   (1st form)
ln [OPTION]... TARGET#                 (2nd form)
ln [OPTION]... TARGET... DIRECTORY     (3rd form)
ln [OPTION]... -t DIRECTORY TARGET...  (4th form)

# DESCRIPTION
#       In the 1st form, create a link to TARGET with the name LINK_NAME.  In the 2nd form, create a link to TARGET in
#       the current directory.  In the 3rd and 4th forms, create links to each TARGET in DIRECTORY.  Create hard links
#       by  default,  symbolic  links  with  --symbolic.   By  default, each destination (name of new link) should not
#       already exist.  When creating hard links, each TARGET must exist.  Symbolic links can hold arbitrary text;  if
#       later resolved, a relative link is interpreted in relation to its parent directory.
#
#       Mandatory arguments to long options are mandatory for short options too.

       --backup[=CONTROL]
#             make a backup of each existing destination file

       -b     like --backup but does not accept an argument

       -d, -F, --directory
#             allow  the  superuser  to  attempt  to  hard  link  directories (note: will probably fail due to system
#             restrictions, even for the superuser)

       -f, --force
#             remove existing destination files

       -i, --interactive
#             prompt whether to remove destinations

       -L, --logical
#             dereference TARGETs that are symbolic links

       -n, --no-dereference
#             treat LINK_NAME as a normal file if it is a symbolic link to a directory

       -P, --physical
#             make hard links directly to symbolic links

       -r, --relative
#             create symbolic links relative to link location

       -s, --symbolic
#             make symbolic links instead of hard links

       -S, --suffix=SUFFIX
#             override the usual backup suffix

       -t, --target-directory=DIRECTORY
#             specify the DIRECTORY in which to create the links

       -T, --no-target-directory
#             treat LINK_NAME as a normal file always

       -v, --verbose
#             print name of each linked file

       --help display this help and exit

       --version
#             output version information and exit

#       The backup suffix is '~', unless set with --suffix or SIMPLE_BACKUP_SUFFIX.  The version control method may be
#       selected via the --backup option or through the VERSION_CONTROL environment variable.  Here are the values:

       none, off
#             never make backups (even if --backup is given)

       numbered, t
#             make numbered backups

       existing, nil
#             numbered if numbered backups exist, simple otherwise

       simple, never
#             always make simple backups

#       Using  -s  ignores  -L and -P.  Otherwise, the last option specified controls behavior when a TARGET is a sym‐
#       bolic link, defaulting to -P.

#AUTHOR
#       Written by Mike Parker and David MacKenzie.
#
#REPORTING BUGS
#       GNU coreutils online help: <http://www.gnu.org/software/coreutils/>
#       Report ln translation bugs to <http://translationproject.org/team/>
#
#COPYRIGHT
#       Copyright  ©  2017  Free  Software  Foundation,  Inc.   License  GPLv3+:  GNU   GPL   version   3   or   later
#       <http://gnu.org/licenses/gpl.html>.
#       This  is  free software: you are free to change and redistribute it.  There is NO WARRANTY, to the extent per‐
#       mitted by law.
#
#SEE ALSO
#       link(2), symlink(2)
#
#       Full documentation at: <http://www.gnu.org/software/coreutils/ln>
#       or available locally via: info '(coreutils) ln invocation'



# run as administrator
# mklink Link Target
mklink /D D:\hello-shell\tools\ftofs D:\ftofs
# mklink - windows
# MKLINK [[/D] | [/H] | [/J]] Link Target
#
#        /D      创建目录符号链接。默认为文件
##               符号链接。
#        /H      创建硬链接而非符号链接。
#        /J      创建目录联接。
#        Link    指定新的符号链接名称。
#        Target  指定新链接引用的路径
##               (相对或绝对)。

