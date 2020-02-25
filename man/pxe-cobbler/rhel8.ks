#version=RHEL8
ignoredisk --only-use=sda
autopart --type=lvm
# Partition clearing information
clearpart --all --initlabel --drives=sda
# Use graphical install
graphical
# repo --name="AppStream" --baseurl=http://192.168.72.2/rhel8/AppStream
# Use CDROM installation media
url --url=http://192.168.72.2/rhel8/
reboot
selinux --disabled

# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network  --bootproto=dhcp --device=ens33 --onboot=on --ipv6=auto

# Root password
rootpw --iscrypted $6$11ek88dTBlk4Qq.0$itUqPXhVYiN8PKbJnNT2jOuQmFHE9DSlc1FSVxz0R1.KwkGgqbGYtxnDQN8nET6X6Fcf/OhLfRJzEB/L1VXwr0
# Run the Setup Agent on first boot
firstboot --enable
# Do not configure the X Window System
skipx
# System services
services --enabled="chronyd"  --disable="firewalld"
# System timezone
timezone Asia/Shanghai --isUtc

%packages
@^minimal-environment

%end

%addon com_redhat_kdump --disable --reserve-mb='auto'

%end

%anaconda
pwpolicy root --minlen=6 --minquality=1 --notstrict --nochanges --notempty
pwpolicy user --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy luks --minlen=6 --minquality=1 --notstrict --nochanges --notempty
%end
