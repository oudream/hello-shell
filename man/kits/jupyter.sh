#!/usr/bin/env bash

jupyter notebook --allow-root

#1. 生成配置文件
jupyter notebook --generate-config

#2. 设置密码
jupyter notebook password

#3. 修改配置文件
vim ~/.jupyter/jupyter_notebook_config.py
#修改以下三个节点的配置，并把开头的 # 注释去掉
#c.NotebookApp.ip = '*' # 开启所有的IP访问，即可使用远程访问
#c.NotebookApp.open_browser = False # 关闭启动后的自动开启浏览器
#c.NotebookApp.port = 80  # 设置端口8888，也可用其他的，比如1080，8080等等

#4. 启动notebook
jupyter notebook

#5. 远程访问
在浏览器输入http://hostip:8888

#6. 主题
pip install jupyterthemes

# list available themes
# onedork | grade3 | oceans16 | chesterish | monokai | solarizedl | solarizedd
jt -l

# select theme...
jt -t chesterish

# jupyter notebook --...
jupyter notebook --no-browser --port 8901 --ip=10.35.191.17
