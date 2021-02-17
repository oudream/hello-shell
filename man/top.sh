#!/usr/bin/env bash

top -Hp <pid>

open https://diabloneo.github.io/2019/08/29/How-to-use-top-command/

# macos 下按键目前不支持
# 按 A 即可（这个可以在两个模式间来回切换)(全屏模式和多窗口模式)
# 按 F 进入字段管理界面
# 按 R 切换排序的方向，默认是从高到底，可以切换为从低到高。
# 按 x 切换是否高亮显示排序列。
# 按 y 切换是否高亮显示 running 的 task。
# 按 b bold/reverse，这个快捷键用于切换关键位置是粗体展示还是反色展示，会影响到 x, y 的展示效果，也会影响到 summary area 的 CPU 进度条 和 memory 进度条的展示效果。
# 按 d 定时刷新间隔，默认是 3s。
# 按 V 切换成森林视图，也就是展示进程父子关系。这个模式下无法按照字段排序。效果如下图：

# 生成配置文件的方式很简单，在你完成想要的定制后，按快捷键 W 即可。
# CentOS 7 上，配置文件的保存路径是 /root/.toprc；Ubuntu 上则是 ~/.config/procps/toprc
