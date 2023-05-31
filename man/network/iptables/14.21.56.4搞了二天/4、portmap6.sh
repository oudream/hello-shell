#!/bin/bash

Dst_Host=$1
Dst_Port=$2
NAT_Host=$3
NAT_Port=$4

Operator=$5
if [ -z "${Operator}" ];then
    Operator='A'
fi

pro=$6
if [ -z "${pro}" ];then
    pro='tcp'
fi

iptables -t nat -${Operator} PREROUTING -m ${pro} -p ${pro} --dport ${NAT_Port} -j DNAT --to-destination ${Dst_Host}:${Dst_Port}
iptables -t nat -${Operator} POSTROUTING -m ${pro} -p ${pro} --dport ${Dst_Port} -d ${Dst_Host} -j SNAT --to-source ${NAT_Host}
