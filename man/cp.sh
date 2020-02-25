#!/usr/bin/env bash

cp -frap new/* old/

cp -r test/ newtest

# 不跟随源文件中的符号链接
cp -RP source target


# cp [options] source dest
#
# -a ：此选项通常在复制目录时使用，它保留链接、文件属性，并复制目录下的所有内容。其作用等于dpR参数组合。
# -d ：复制时保留链接。这里所说的链接相当于Windows系统中的快捷方式。
# -f ：覆盖已经存在的目标文件而不给出提示。
# -i ：与-f选项相反，在覆盖目标文件之前给出提示，要求用户确认是否覆盖，回答"y"时目标文件将被覆盖。
# -P :  --no-dereference   不跟随源文件中的符号链接
# -p ：除复制文件的内容外，还把修改时间和访问权限也复制到新文件中。
# -r ：若给出的源文件是一个目录文件，此时将复制该目录下所有的子目录和文件。
# -l ：不复制文件，只是生成链接文件。
# -n, --no-clobber   不要覆盖已存在的文件(使前面的 -i 选项失效)


       cp [OPTION]... [-T] SOURCE DEST
       cp [OPTION]... SOURCE... DIRECTORY
       cp [OPTION]... -t DIRECTORY SOURCE...

#DESCRIPTION
#       Copy SOURCE to DEST, or multiple SOURCE(s) to DIRECTORY.
#
#       Mandatory arguments to long options are mandatory for short options too.

       -a, --archive
            # same as -dR --preserve=all

       --attributes-only
            # don't copy the file data, just the attributes

       --backup[=CONTROL]
            # make a backup of each existing destination file

       -b   #  like --backup but does not accept an argument

       --copy-contents
            # copy contents of special files when recursive

       -d   # same as --no-dereference --preserve=links

       -f, --force
            # if  an  existing  destination file cannot be opened, remove it and try again (this option is ignored when the -n
            # option is also used)

       -i, --interactive
            # prompt before overwrite (overrides a previous -n option)

       -H   # follow command-line symbolic links in SOURCE

       -l, --link
            # hard link files instead of copying

       -L, --dereference
            # always follow symbolic links in SOURCE

       -n, --no-clobber
            # do not overwrite an existing file (overrides a previous -i option)

       -P, --no-dereference
            # never follow symbolic links in SOURCE

       -p   # same as --preserve=mode,ownership,timestamps

       --preserve[=ATTR_LIST]
            # preserve the specified attributes (default: mode,ownership,timestamps), if possible additional attributes:  con‐
            # text, links, xattr, all

       --no-preserve=ATTR_LIST
            # don't preserve the specified attributes

       --parents
            # use full source file name under DIRECTORY

       -R, -r, --recursive
            # copy directories recursively

       --reflink[=WHEN]
            # control clone/CoW copies. See below

       --remove-destination
            # remove each existing destination file before attempting to open it (contrast with --force)

       --sparse=WHEN
            # control creation of sparse files. See below

       --strip-trailing-slashes
            # remove any trailing slashes from each SOURCE argument

       -s, --symbolic-link
            # make symbolic links instead of copying

       -S, --suffix=SUFFIX
            # override the usual backup suffix

       -t, --target-directory=DIRECTORY
            # copy all SOURCE arguments into DIRECTORY

       -T, --no-target-directory
            # treat DEST as a normal file

       -u, --update
            # copy only when the SOURCE file is newer than the destination file or when the destination file is missing

       -v, --verbose
            # explain what is being done

       -x, --one-file-system
            # stay on this file system

       -Z   # set SELinux security context of destination file to default type

       --context[=CTX]
            # like -Z, or if CTX is specified then set the SELinux or SMACK security context to CTX

       --help # display this help and exit

       --version
            # output version information and exit

#       By  default,  sparse  SOURCE  files are detected by a crude heuristic and the corresponding DEST file is made sparse as
#       well.  That is the behavior selected by --sparse=auto.  Specify --sparse=always to create a sparse DEST  file  whenever
#       the SOURCE file contains a long enough sequence of zero bytes.  Use --sparse=never to inhibit creation of sparse files.
#
#       When  --reflink[=always] is specified, perform a lightweight copy, where the data blocks are copied only when modified.
#       If this is not possible the copy fails, or if --reflink=auto is specified, fall back to a standard copy.
#
#       The backup suffix is '~', unless set with --suffix or SIMPLE_BACKUP_SUFFIX.  The version control method may be selected
#       via the --backup option or through the VERSION_CONTROL environment variable.  Here are the values:
#
#       none, off
