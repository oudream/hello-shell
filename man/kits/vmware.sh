#!/usr/bin/env bash


vmrun -T ws start "/fff/vm1/vm-ubuntu1.vmx" nogui
vmrun -T ws start "/fff/vm2/vm-ubuntu1.vmx" nogui

### vmware
#https://docs.vmware.com/cn/VMware-Fusion/11/com.vmware.fusion.using.doc/GUID-3E063D73-E083-40CD-A02C-C2047E872814.html
vmrun -T ws start "/opt/VMware/win2k8r2.vmx" nogui
# 启动无图形界面虚拟机
#（-T 是区分宿主机的类型，ws|server|server1|fusion|esx|vc|player，比较常用的是ws、esx和player）
vmrun start "/opt/VMware/win2k8r2.vmx" gui
# 启动带图形界面虚拟机
vmrun stop "/opt/VMware/win2k8r2.vmx" hard | soft
# 强制关闭虚拟机(相当于直接关电源) | 正常关闭虚拟机
vmrun reset "/opt/VMware/win2k8r2.vmx" hard | soft
# 冷重启虚拟机 | 热重启虚拟机
vmrun suspend  "/opt/VMware/win2k8r2.vmx" hard | soft
# 挂起虚拟机（可能相当于休眠）
vmrun pause  "/opt/VMware/win2k8r2.vmx"
# 暂停虚拟机
vmrun unpause  "/opt/VMware/win2k8r2.vmx"
# 停止暂停虚拟机
vmrun list
# 列出正在运行的虚拟机
ps aux | grep vmx
# 另一种查看正在运行虚拟机的方法
vmrun -T ws snapshot "/opt/VMware/win2k8r2.vmx" snapshotName
# 创建一个快照（snapshotName 快照名）
vmrun -T ws reverToSnapshot "/opt/VMware/win2k8r2.vmx" snapshotName
# 从一个快照中恢复虚拟机（snapshotName 快照名）
vmrun -T ws listSnapshots "/opt/VMware/win2k8r2.vmx"
# 列出虚拟机快照数量及名称
vmrun -T ws deleteSnapshot "/opt/VMware/win2k8r2.vmx" snapshotName
# 删除一个快照（snapshotName 快照名）

