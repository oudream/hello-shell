
cat /proc/sys/net/ipv4/ip_forward
echo 1 > /proc/sys/net/ipv4/ip_forward

iptables -vL -t nat

iptables -F && iptables -X && iptables -F -t nat && iptables -X -t nat

iptables -t nat -A PREROUTING -m tcp -p tcp --dport 5092 -j DNAT --to-destination 10.50.53.182:92
iptables -t nat -D PREROUTING -m tcp -p tcp --dport 5092 -j DNAT --to-destination 10.50.53.182:92

iptables -t nat -A POSTROUTING -m tcp -p tcp --dport 92 -d 10.50.53.182 -j SNAT -o vmbr0 --to-source 14.21.56.4
iptables -t nat -D POSTROUTING -m tcp -p tcp --dport 92 -d 10.50.53.182 -j SNAT -o vmbr0 --to-source 14.21.56.4

nc -k -lp 99

tcpdump -i eno2 port 5092 -w 001.pcap
tcpdump -i vmbr0 host 10.50.53.182 -w 002.pcap
tcpdump -i eth0 port 92 -w 001.pcap

iptables -t nat -A PREROUTING -m tcp -p tcp --dport 5093 -j DNAT --to-destination 10.50.53.182:93
iptables -t nat -A POSTROUTING -m tcp -p tcp --dport 93 -d 10.50.53.182 -j SNAT -o vmbr0 --to-source 14.21.56.4
