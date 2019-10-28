#!/usr/bin/expect

set user root
set ipaddress 45.77.131.42
set passwd "Z-j8\$S5-E\@\}\[97\?1"
set timeout 30

spawn ssh $user@$ipaddress
expect {
    "*password:" { send "$passwd\r" }
    "yes/no" { send "yes\r";exp_continue }
}
expect {
    "*vultr-ubuntu1:~#" {send "screen -r vm1\r"}
}
interact
