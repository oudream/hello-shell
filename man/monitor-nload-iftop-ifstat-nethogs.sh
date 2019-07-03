#!/usr/bin/env bash

nethogs: 按进程查看流量占用
iptraf: 按连接/端口查看流量
ifstat: 按设备查看流量
ethtool: 诊断工具
tcpdump: 抓包工具
ss: 连接查看工具


# nload默认的是eth0网卡，如果你想监测eth1网卡的流量

nload eth1

# -a：这个好像是全部数据的刷新时间周期，单位是秒，默认是300.
# -i：进入网卡的流量图的显示比例最大值设置，默认10240 kBit/s.
# -m：不显示流量图，只显示统计数据。
# -o：出去网卡的流量图的显示比例最大值设置，默认10240 kBit/s.
# -t：显示数据的刷新时间间隔，单位是毫秒，默认500。
# -u：设置右边Curr、Avg、Min、Max的数据单位，默认是自动变的.注意大小写单位不同！
#     h|b|k|m|g h: auto, b: Bit/s, k: kBit/s, m: MBit/s etc.
#     H|B|K|M|G H: auto, B: Byte/s, K: kByte/s, M: MByte/s etc.
# nload 命令一旦执行就会开始监控网络设备，你可以使用下列快捷键操控 nload 应用程序。
#     你可以按键盘上的 ← → 或者 Enter/Tab 键在设备间切换。按 F2 显示选项窗口。
#     按 F5 将当前设置保存到用户配置文件。按 F6 从配置文件重新加载设置。按 q 或者 Ctrl+C 退出 nload。


# nethogs
# 自定义刷新频率
# 在启动 nethogs 时使用 -d seconds 参数定义刷新频率
nethogs -d 1 # 每秒钟刷新

感觉被骗了

昨天收到银行欠费，查了才知道是 AWS 在5月分时收了一笔 :
日期：2019-05-03，单号：212707473，卡号：尾号为 2455，Charge CreditCard $83.85。
感觉很惊讶。
你们知道一个人的信用多么重要吗？我从来很小心处理这方面的问题，我在中国目前很少用信用卡，所以突然有
这个问题，我真的很恼火，接收不了。
我在四月分在网上看到你们广告，免费试用 AWS 一年，我点击进去，所免费规则生成实例。我核查符合免费,我才
开启实例，但今天不知道为什么你们会收了我费用，惊讶，感觉被骗了。
帮我追回收费



Feeling cheated

I received a bank arrears yesterday, and I found out that AWS received a sum of money in May:
Date: 2019-05-03, number: 212707473, card number: the tail number is 2455, Charge CreditCard $83.85.
I feel very surprised.
Do you know how important a person's credit is? I have been very careful in dealing with this problem. I rarely use credit cards in China, so suddenly there are
I am really annoyed with this question and can't receive it.
I saw your ad on the Internet in April, and tried AWS for free for a year. I clicked in and created an instance of the free rule. My verification is free, I only
Open the instance, but today I don't know why you will charge me, surprised, and feel cheated.
Help me recover the charges