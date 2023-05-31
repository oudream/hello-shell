
# redhat - nftables 入门
# https://access.redhat.com/documentation/zh-cn/red_hat_enterprise_linux/7/html/security_guide/chap-getting_started_with_nftables

# 一个简单的基于nftables的端口转发工具
# https://github.com/kzw200015/nfg

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
