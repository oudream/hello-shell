#version=DEVEL
# System authorization information
auth --enableshadow --passalgo=sha512
# Use CDROM installation media
#cdrom
url --url http://192.168.72.2/centos7/

# Use graphical install
# graphical
text
reboot
selinux --disabled
# Run the Setup Agent on first boot
firstboot --enable
ignoredisk --only-use=sda
# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network  --bootproto=dhcp --device=ens33 --onboot=on --noipv6 
network  --hostname=localhost

# Root password
rootpw --iscrypted $6$ZG/SVZBlg7fGdgjx$hcHX.aoHPxMGbu968ZezzwEYzd6lIieOaU8VBZnojQ0jQG/PNgBsVmbyoM/FaRMDB0T8rHOLHk3DscaXetgOA/
# System services
services --enabled="chronyd"
# System timezone
timezone Asia/Shanghai --isUtc
# System bootloader configuration
clearpart --all --drives=sda
bootloader --append=" crashkernel=auto" --location=mbr --boot-drive=sda
autopart --type=lvm
# Partition clearing information
#clearpart --none --initlabel

%packages
@^minimal
@core
chrony
kexec-tools

%end

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end

%anaconda
pwpolicy root --minlen=6 --minquality=1 --notstrict --nochanges --notempty
pwpolicy user --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy luks --minlen=6 --minquality=1 --notstrict --nochanges --notempty
%end
