#!/usr/bin/env bash

pipenv run pip freeze > requirements.txt

# install pipenv
pip3 install pipenv
# pip install --user pipenv

# install , uninstall , update
pipenv install urllib3
pipenv install urllib3==1.22
pipenv uninstall urllib3
pipenv update urllib3
# update all
pipenv update

# 安装命令时通过--pypi-mirror选项指定PyPI源，比如：
pipenv install --pypi-mirror https://mirrors.aliyun.com/pypi/simple
#                pypi      https://pypi.python.org/simple/
#                douban      http://pypi.douban.com/simple/
#                aliyun      http://mirrors.aliyun.com/pypi/simple/
#                qinghua      https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple/

# show all env
pipenv --venv

# Create a new project using Python 3.7, specifically:
pipenv --python 3.7

# Remove project virtualenv (inferred from current directory):
pipenv --rm

# Install all dependencies for a project (including dev):
pipenv install --dev

# Create a lockfile containing pre-releases:
pipenv lock --pre

# Show a graph of your installed dependencies:
pipenv graph

# Check your installed dependencies for security vulnerabilities:
pipenv check

# Install a local setup.py into your virtual environment/Pipfile:
pipenv install -e .

# Use a lower-level pip command:
pipenv run pip freeze

# shell 自动补齐
#Linux or Mac 环境下，bash下如果能自动命令补全岂不是更好？请把如下语句追加到.bashrc或者.zshrc即可：
eval "$(pipenv --completion)"


pipenv [OPTIONS] COMMAND [ARGS]...

# Options:
  --where            # 显示项目文件所在路径
  --venv             # 显示虚拟环境实际文件所在路径
  --py               # 显示虚拟环境Python解释器所在路径
  --envs             # 显示虚拟环境的选项变量
  --rm               # 删除虚拟环境
  --bare             # 最小化输出
  --completion       # 完整输出
  --man              # 显示帮助页面
  --three / --two    # 使用Python 3/2创建虚拟环境（注意本机已安装的Python版本）
  --python TEXT      # 指定某个Python版本作为虚拟环境的安装源
  --site-packages    # 附带安装原Python解释器中的第三方库
  --jumbotron        # An easter egg, effectively.
  --version          # 版本信息
  -h, --help         # 帮助信息

# Commands:
  check             # 检查安全漏洞
  graph             # 显示当前依赖关系图信息
  install           # 安装虚拟环境或者第三方库
  lock              # 锁定并生成Pipfile.lock文件
  open              # 在编辑器中查看一个库
  run               # 在虚拟环境中运行命令
  shell             # 进入虚拟环境
  uninstall         # 卸载一个库
  update            # 卸载当前所有的包，并安装它们的最新版本


# Options:
  --where                         Output project home information.
  --venv                          Output virtualenv information.
  --py                            Output Python interpreter information.
  --envs                          Output Environment Variable options.
  --rm                            Remove the virtualenv.
  --bare                          Minimal output.
  --completion                    Output completion (to be executed by the
                                  shell).

  --man                           Display manpage.
  --support                       Output diagnostic information for use in
                                  GitHub issues.

  --site-packages / --no-site-packages
                                  Enable site-packages for the virtualenv.
                                  [env var: PIPENV_SITE_PACKAGES]

  --python TEXT                   Specify which version of Python virtualenv
                                  should use.

  --three / --two                 Use Python 3/2 when creating virtualenv.
  --clear                         Clears caches (pipenv, pip, and pip-tools).
                                  [env var: PIPENV_CLEAR]

  -v, --verbose                   Verbose mode.
  --pypi-mirror TEXT              Specify a PyPI mirror.
  --version                       Show the version and exit.
  -h, --help                      Show this message and exit.

# Commands:
  check      Checks for PyUp Safety security vulnerabilities and against PEP
             508 markers provided in Pipfile.

  clean      Uninstalls all packages not specified in Pipfile.lock.
  graph      Displays currently-installed dependency graph information.
  install    Installs provided packages and adds them to Pipfile, or (if no
             packages are given), installs all packages from Pipfile.

  lock       Generates Pipfile.lock.
  open       View a given module in your editor.
  run        Spawns a command installed into the virtualenv.
  shell      Spawns a shell within the virtualenv.
  sync       Installs all packages specified in Pipfile.lock.
  uninstall  Uninstalls a provided package and removes it from Pipfile.
  update     Runs lock, then sync.
