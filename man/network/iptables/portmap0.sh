#!/bin/bash
pro='tcp'
NAT_Host='14.21.56.4'
NAT_Port=5022
Dst_Host='10.50.53.182'
Dst_Port=22
iptables -t nat -A PREROUTING -m $pro -p $pro --dport $NAT_Port -j DNAT --to-destination $Dst_Host:$Dst_Port
iptables -t nat -A POSTROUTING -m $pro -p $pro --dport $Dst_Port -d $Dst_Host -j SNAT --to-source $NAT_Host
