#!/usr/bin/env bash

open https://github.com/inotify-tools/inotify-tools/wiki

inotifywait -m --timefmt '%d/%m/%y %H:%M' --format '%T %w %f' -r /tmp/test
inotifywait -mr --timefmt '%d/%m/%y %H:%M' --format '%T %w %f' -e close_write /tmp/test

# 实时监控/home的所有事件（包括文件的访问，写入，修改，删除等）
inotifywait -rm /tmp/test

# 统计/home文件系统60秒内发生的事件
# In this example, I’m recursively watching ~/home for 60 seconds, while beagled is running.
inotifywatch -v -e access -e modify -t 60 -r /home


# inotifywait example 1
# get the current path
CURPATH=`pwd`
inotifywait -mr --timefmt '%d/%m/%y %H:%M' --format '%T %w %f' \
    -e close_write /tmp/test | while read date time dir file; do
           FILECHANGE=${dir}${file}
           # convert absolute path to relative
           FILECHANGEREL=`echo "$FILECHANGE" | sed 's_'$CURPATH'/__'`
           rsync --progress --relative -vrae 'ssh -p 22'  $FILECHANGEREL usernam@example.com:/backup/root/dir && \
           echo "At ${time} on ${date}, file $FILECHANGE was backed up via rsync"
done


inotifywait -mr --timefmt '%d/%m/%y %H:%M' --format '%T %w %f' \
    -e close_write /tmp/test | while read date time dir file; do
           FILECHANGE=${dir}${file}
           echo "At ${time} on ${date}, file $FILECHANGE was close_write"
done


# inotifywait example 2
EVENT=$(inotifywait --format '%e' ~/file1)
[ $? != 0 ] && exit
[ "$EVENT" = "MODIFY" ] && echo 'file modified!'
[ "$EVENT" = "DELETE_SELF" ] && echo 'file deleted!'
# etc...


### inotifywait
# inotifywait 仅执行阻塞，等待 inotify 事件，你可以使用它来监控任何一组文件和目录，
#   或监控整个目录树（目录、子目录、子目录的子目录等等），并且可以结合 shell 脚本，更好的使用 inotifywait。


### config
/proc/sys/fs/inotify/max_queued_events
#    默认值: 16384
#    该文件中的值为调用inotify_init时分配给inotify instance中可排队的event的数目的最大值，超出这个值得事件被丢弃，但会触发IN_Q_OVERFLOW事件
/proc/sys/fs/inotify/max_user_instances
#    默认值: 128
#    指定了每一个real user ID可创建的inotify instatnces的数量上限
/proc/sys/fs/inotify/max_user_watches
#    默认值: 8192
#    指定了每个inotify instance相关联的watches的上限，也就是每一个inotify实例可监控的最大目录数。如果监控的文件数目巨大，需要根据实际情况适当增加此值得大小。
#注意:
#    max_queued_events 是 Inotify 管理的队列的最大长度，文件系统变化越频繁，这个值就应该越大！如果你在日志中看到Event Queue Overflow，说明max_queued_events太小需要调整参数后再次使用


inotifywatch [ options ] file1 [ file2 ] [ ... ]
#    Options:
        -h|--help    	# Show this help text.
        -v|--verbose 	# Be verbose.
        @<file>       	# Exclude the specified file from being watched.
        --fromfile <file>
                        # Read files to watch from <file> or `-' for stdin.
        --exclude <pattern>
                        # Exclude all events on files matching the extended regular
                        # expression <pattern>.
        --excludei <pattern>
                        # Like --exclude but case insensitive.
        -z|--zero
                        # In the final table of results, output rows and columns even
                        # if they consist only of zeros (the default is to not output
                        # these rows and columns).
        -r|--recursive	# Watch directories recursively.
        -t|--timeout <seconds>
                        # Listen only for specified amount of time in seconds; if
                        # omitted or 0, inotifywatch will execute until receiving an
                        # interrupt signal.
        -e|--event <event1> [ -e|--event <event2> ... ]
                        # Listen for specific event(s).  If omitted, all events are
                        # listened for.
        -a|--ascending <event>
                        # Sort ascending by a particular event, or `total'.
        -d|--descending <event>
                        # Sort descending by a particular event, or `total'.
#
#    Exit status:
#        0  -  Exited normally.
#        1  -  Some error occurred.
#
#    Events:
        access		    # file or directory contents were read
        modify		    # file or directory contents were written
        attrib		    # file or directory attributes changed
        close_write	    # file or directory closed, after being opened in writable mode
        close_nowrite	# file or directory closed, after being opened in read-only mode
        close		    # file or directory closed, regardless of read/write mode
        open		    # file or directory opened
        moved_to	    # file or directory moved to watched directory
        moved_from	    # file or directory moved from watched directory
        move		    # file or directory moved to or from watched directory
        create		    # file or directory created within watched directory
        delete		    # file or directory deleted within watched directory
        delete_self	    # file or directory was deleted
        unmount		    # file system containing file or directory unmounted


inotifywait [ options ] file1 [ file2 ] [ file3 ] [ ... ]
# Options:
	-h|--help     	        # Show this help text.
    @<file>       	        # Exclude the specified file from being watched.
	--exclude <pattern>     # Exclude all events on files matching the
	              	        # extended regular expression <pattern>.
	--excludei <pattern>    # Like --exclude but case insensitive.
	-m|--monitor  	        # Keep listening for events forever.  Without
	              	        # this option, inotifywait will exit after one
	              	        # event is received.
	-d|--daemon   	        # Same as --monitor, except run in the background
	              	        # logging events to a file specified by --outfile.
	              	        # Implies --syslog.
	-r|--recursive	        # Watch directories recursively.
	--fromfile <file>       # Read files to watch from <file> or `-' for stdin.
	-o|--outfile <file>     # Print events to <file> rather than stdout.
	-s|--syslog   	        # Send errors to syslog rather than stderr.
	-q|--quiet    	        # Print less (only print events).
	-qq           	        # Print nothing (not even events).
	--format <fmt>	        # Print using a specified printf-like format
	              	        # string; read the man page for more details.
	--timefmt <fmt>	        # strftime-compatible format string for use with
	              	        # %T in --format string.
	-c|--csv      	        # Print events in CSV format.
	-t|--timeout <seconds>  # When listening for a single event, time out after
	              	        # waiting for an event for <seconds> seconds.
	              	        # If <seconds> is 0, inotifywait will never time out.
	-e|--event <event1> [ -e|--event <event2> ... ]
		                    # Listen for specific event(s).  If omitted, all events are
		                    # listened for.
#
#    Exit status:
#        0  -  An event you asked to watch for was received.
#        1  -  An event you did not ask to watch for was received
#              (usually delete_self or unmount), or some error occurred.
#        2  -  The --timeout option was given and no events occurred
#              in the specified interval of time.



### install
#    Mageia
#    inotify-tools is available in the Mageia core repository. You can install it with:
urpmi inotify-tools

#    Fedora
#    inotify-tools is available through the Fedora Extras repository. Just do:
yum install inotify-tools

# Adel Gadllah is the Fedora package maintainer.
#    CentOS/RHEL 7
#    inotify-tools is available through the EPEL repository. Install EPEL :
yum install -y epel-release && yum update
#    Then install package:
yum install inotify-tools

# In case of CentOS-7
yum --enablerepo=epel install inotify-tools
# v3.14-8.el7.×86_64 as of 4-18-2018

#    Gentoo
#    inotify-tools is available in Gentoo’s official portage tree. You can simply run:
emerge inotify-tools
#    to install it
#    Lars Wendler is the Gentoo package maintainer.

#    Debian/Ubuntu
#    inotify-tools is available in Debian’s official repositories. You can install it by:
apt-get install inotify-tools

#    Ryan Niebur is the Debian package maintainer.
#    Void Linux
#    inotify-tools is available in Void Linux. It can be installed with the following command:
xbps-install inotify-tools

#    Enno Boland is the Void Linux package maintainer.
#    Alpine Linux
#    inotify-tools is available in the Alpine Linux main repository. You can install it with:
apk add inotify-tools

#    FreeBSD
#    inotify-tools is available as a port and package. It can be installed with the following command:
pkg install inotify-tools
# or
cd /usr/ports/sysutils/inotify-tools/ && make install clean

#    Yuri is the FreeBSD package maintainer.
#    ALT Linux
#    inotify-tools is available in the Sisyphus repository. With ALT Linux Sisyphus you can install by the following command:
apt-get install inotify-tools

#    Igor Zubkov (@biow0lf) is the ALT Linux Sisyphus package maintainer.
#    Frugalware Linux
#    inotify-tools is available in Frugalware Linux. It can be installed with the following command:
pacman-g2 -S inotify-tools

#    Priyank Gosalia is the Frugalware Linux package maintainer.
#    Arch Linux
#    inotify-tools is available in Arch Linux. It can be installed with the following command:
pacman -S inotify-tools

#    Sergej Pupykin is the Arch Linux package maintainer.
#    NixOS Linux
#    inotify-tools is available in nixpkgs. It can be installed with the following command:
nix-env -i inotify-tools

#    Github users marcweber and pSub are the NixOS package maintainers.
#    Source Mage GNU/Linux
#    inotify-tools can be installed with the following command:
cast inotify-tools

#    Package maintained by the Source Mage team.
#    ROSA Linux
#    inotify-tools can be installed from the Contrib repository by running:
urpmi inotify-tools

#    Denis Silakov is the ROSA Linux package maintainer.
#    Slackware
#    comes with inotify-tools by default

#    PLD Linux
#    inotify-tools is available in PLD Linux. It can be installed with the following command:
poldek -u inotify-tools

#    Everyone Else
#    Download inotify-tools source from Github project page then compile and install:
./configure --prefix=/usr && make && su -c 'make install'
