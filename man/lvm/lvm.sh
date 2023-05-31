#!/usr/bin/env bash


### install
sudo yum install lvm2


# PV阶段
  pvcreate    # 将物理分区新建成PV
  pvscan      # 参看系统中任何具有PV的磁盘
  pvs         # 显示系统中的PV的简略信息
  pvdisplay   # 显示系统中PV的详细信息。
  pvremove    # 将PV属性删除，使该磁盘不再具有PV属性


# VG阶段
  vgcreate    # 新建卷组
    -s        # 指定PE的大小，单位可以是mMgGtT,PE默认大小为4M
  cgscan
  vgs         # 显示卷组的简略信息
  vgdisplay   # 显示卷组的详细信息
  vgextend    # 在卷组中增加新的PV
  vgreduce    # 减少卷组中的PV
  vgchange    # 设置卷组是否启用
  vgremove    # 删除一个VG


# LV阶段
  lvcreate   # 新建LV
    -c # 指定快照逻辑卷的单位的大小
    -C # 设置或重置连续分配策略
    -i # 指定条带数
    -I # 指定每个条带的大小
    -l # 指定分配给新逻辑卷的逻辑区段数，或者要用的逻辑区段的百分比
    -L # 指定分配给新逻辑卷的硬盘大小
    -m # 创建逻辑卷镜像
    -M # 让次设备号一直有效
    -n # 指定新逻辑卷的名称
    -p # 为逻辑卷设置读写权限
    -r # 设置预读扇区数
    -R # 指定将镜像分成多大的区
    -s # 创建快照逻辑卷
    -Z # 将新逻辑卷的前1KB数据设置为0
  lvscan     # 查询系统上的LV
  lvs        # 查看LV的简略信息
  lvdisplay  # 查看LV的详细信息
  lvextend   # 增加LV的容量
  lvreduce   # 减小LV的容量
  lvrenove   # 删除一个LV
  lvresize   # 对LV进行容量大小的调整
