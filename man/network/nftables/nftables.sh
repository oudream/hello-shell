vim.tiny tranfrom.nft
systemctl restart nftables.service
nft list ruleset
tcpdump -i eno2 port 5092 -v -w 001.pcap

nc -k -lp 93

vim /etc/sysctl.conf
# add
net.ipv4.ip_forward=1
# 或
echo 1 > /proc/sys/net/ipv4/ip_forward
cat /proc/sys/net/ipv4/ip_forward
