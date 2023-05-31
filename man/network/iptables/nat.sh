
# https://www.npbeta.com/2021/06/iptables_pve_nat/

./portmap6.sh 192.168.11.109 94 14.21.56.4 5094 A TCP
./portmap6.sh 192.168.11.109 94 14.21.56.4 5094 A
./portmap6.sh 192.168.11.109 22 14.21.56.4 5022
./portmap6.sh 192.168.11.109 22 14.21.56.4 5022 D

cat /proc/sys/net/ipv4/ip_forward
echo 1 > /proc/sys/net/ipv4/ip_forward

iptables -vL -t nat

iptables -F && iptables -X && iptables -F -t nat && iptables -X -t nat

iptables -t nat -A PREROUTING -m tcp -p tcp --dport 5092 -j DNAT --to-destination 192.168.11.109:92
iptables -t nat -D PREROUTING -m tcp -p tcp --dport 5092 -j DNAT --to-destination 192.168.11.109:92

iptables -t nat -A POSTROUTING -m tcp -p tcp --dport 92 -d 192.168.11.109 -j SNAT -o vmbr0 --to-source 14.21.56.4
iptables -t nat -D POSTROUTING -m tcp -p tcp --dport 92 -d 192.168.11.109 -j SNAT -o vmbr0 --to-source 14.21.56.4

nc -k -lp 99

tcpdump -i eno2 port 5092 -w 001.pcap
tcpdump -i vmbr0 host 192.168.11.109 -w 002.pcap
tcpdump -i eth0 port 92 -w 001.pcap

iptables -t nat -A PREROUTING -m tcp -p tcp --dport 5093 -j DNAT --to-destination 192.168.11.109:93
iptables -t nat -A POSTROUTING -m tcp -p tcp --dport 93 -d 192.168.11.109 -j SNAT -o vmbr0 --to-source 14.21.56.4
