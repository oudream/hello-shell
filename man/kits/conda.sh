#!/usr/bin/env bash

# https://docs.conda.io/projects/conda/en/latest/commands.html


conda install -c conda-forge opencv

conda remove opencv libopencv py-opencv --force


### install
pip install   ～/Downloads/a.whl #pip 安装本地包
conda install --use-local  ~/Downloads/a.tar.bz2 # #conda 安装本地包


# update
conda update conda
conda update anaconda
conda update anaconda-navigator    # update最新版本的anaconda-navigator


### remove uninstall(Alias for conda remove)
conda remove -n xxxx --all        # 创建xxxx虚拟环境
# 计算机控制面板->程序与应用->卸载      # windows
rm -rf anaconda    # ubuntu 删除整个 anaconda


### clean
conda clean -p      //删除没有用的包
conda clean -t      //删除tar包
conda clean -y -all //删除所有的安装包及cache


### env
# 最后，建议清理下.bashrc中的Anaconda路径。
# conda环境使用基本命令：
conda update -n base conda        # update最新版本的conda
conda create -n xxxx python=3.5   # 创建python3.5的xxxx虚拟环境
conda activate xxxx               # 开启xxxx环境
conda deactivate                  # 关闭环境
conda env list                    # 显示所有的虚拟环境
conda remove -n xxxx --all        # 创建xxxx虚拟环境
# env rename
conda create --name newname --clone oldname     # 克隆环境
conda remove --name oldname --all               # 彻底删除旧环境
# activate
conda activate   #默认激活base环境
conda activate xxx  #激活xxx环境
conda deactivate #关闭当前环境
conda config --set auto_activate_base false     # 关闭自动激活状态
conda config --set auto_activate_base true      # 关闭自动激活状态



### search
anaconda search -t conda tensorflow
anaconda show <USER/PACKAGE>



### 例如, 添加清华anaconda镜像：
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
conda config --set show_channel_urls yes


cat > ~/.condarc <<EOF
auto_activate_base: false
channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/menpo/
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/msys2/
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
show_channel_urls: true
EOF


# usage: conda [-h] [-V] command
# Anaconda
open https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html
open https://docs.conda.io/projects/conda/en/latest/user-guide/install/download.html
# open https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh
wget -O Anaconda-latest-Linux-x86_64.sh https://repo.anaconda.com/archive/Anaconda3-2019.10-MacOSX-x86_64.sh
bash Anaconda-latest-Linux-x86_64.sh

open https://docs.conda.io/projects/conda/en/latest/commands.html
usage: conda [-h] [-V] command ...
# conda is a tool for managing and deploying applications, environments and packages.
# Options:
# positional arguments:
#   command
    clean        # Remove unused packages and caches.
    config       # Modify configuration values in .condarc. This is modeled
                 # after the git config command. Writes to the user .condarc
                 # file (/root/.condarc) by default.
    create       # Create a new conda environment from a list of specified
                 # packages.
    help         # Displays a list of available conda commands and their help
                 # strings.
    info         # Display information about current conda install.
    init         # Initialize conda for shell interaction. [Experimental]
    install      # Installs a list of packages into a specified conda
                 # environment.
    list         # List linked packages in a conda environment.
    package      # Low-level conda package utility. (EXPERIMENTAL)
    remove       # Remove a list of packages from a specified conda environment.
    uninstall    # Alias for conda remove.
    run          # Run an executable in a conda environment. [Experimental]
    search       # Search for packages and display associated information. The
                 # input is a MatchSpec, a query language for conda packages.
                 # See examples below.
    update       # Updates conda packages to the latest compatible version.
    upgrade      # Alias for conda update.

# optional arguments:
#   -h, --help     Show this help message and exit.
#   -V, --version  Show the conda version number and exit.


