#!/usr/bin/env bash

# npmmirror 中国镜像站
# https://npmmirror.com/
npm install -g cnpm --registry=https://registry.npmmirror.com
alias cnpm="npm --registry=https://registry.npmmirror.com --cache=$HOME/.npm/.cache/cnpm --disturl=https://npmmirror.com/mirrors/node --userconfig=$HOME/.cnpmrc"


# https://docs.npmjs.com/cli-documentation/cli
# https://docs.npmjs.com/cli/install


npm install -f packages-win32.json

### cache
npm cache clean -f
npm install -g vue-cli --cache /tmp/empty-cache

# 您还可以通过以下方式嗅出操作系统：
# nodejs:
# const _isWin = /^win/.test( process.platform )


### 安装 32位
# 需要编译的
node-gyp clean configure build --verbose --arch=ia32
#方式一：直接 npm 安装
npm install --arch=ia32 electron@1.4.14
#方式二：配置 .npmrc
#arch=ia32
#registry=https://registry.npm.taobao.org
#方式三：配置 package.json
#{
#  "config": {
#    "arch": "ia32",
#    "registry": "https://registry.npm.taobao.org"
#  },
#  "devDependencies": {
#    "electron": "1.4.14"
#  }
#}

# .npmrc
# registry=https://registry.npm.taobao.org/
# disturl=https://npm.taobao.org/dist



npm --help

# 初始化一个基于node的项目，会创建一个配置文件package.json（两种方式）:
npm init
# 全部使用默认配置
npm init --yes

# 安装模块（包）：
# 全局安装
npm install ${MODULE_NAME} -g
# 本地安装
npm install ${MODULE_NAME}
# 一次性安装多个
npm install 模块1 模块2 模块n --save
# 安装运行时依赖包
npm install ${MODULE_NAME} --save
# 安装开发时依赖包
npm install ${MODULE_NAME} --save-dev

#    npm install (with no args, in package dir)
#    npm install [<@scope>/]<name>
#    npm install [<@scope>/]<name>@<tag>
#    npm install [<@scope>/]<name>@<version>
#    npm install [<@scope>/]<name>@<version range>
#    npm install <git-host>:<git-user>/<repo-name>
#    npm install <git repo url>
#    npm install <tarball file>
#    npm install <tarball url>
#    npm install <folder>
#
#    aliases: npm i, npm add
#    common options: [-P|--save-prod|-D|--save-dev|-O|--save-optional] [-E|--save-exact]
#    [-B|--save-bundle] [--no-save] [--dry-run]

# 查看安装目录：
# 查看本地安装的目录
npm root
# 查看全局安装的目录
# npm root -g

# 卸载模块（包）：
# 卸载本地模块
npm uninstall $MODULE_NAME
# 卸载全局模块
npm uninstall -g ${MODULE_NAME}
# 更新模块（包）
npm update ${MODULE_NAME}
npm update ${MODULE_NAME} -g
# 查看当前安装的模块（包）
npm ls
npm ls -g
# 查看模块（包）的信息：
npm info ${MODULE_NAME}

## package.json文件的配置说明：
cat >> package.json <<EOF
{
  "name": "blog",  项目名称
  "version": "0.0.0",   //版本
  "description": "",   //项目描述
  "private": true,
  "main": "index.js",  //入口文件
  "scripts": {   //配置一些通用的命令脚本
    "start": "node ./bin/www"
  },
  "keywords": [],  //项目的关键字
  "author": "",  //作者
  "dependencies": {   //开发时的依赖
    "body-parser": "~1.16.0",
    "cookie-parser": "~1.4.3",
    "debug": "~2.6.0",
    "ejs": "~2.5.5",
    "express": "~4.14.1",
    "morgan": "~1.7.0",
    "serve-favicon": "~2.3.2"
  },
  "devDependencies": {   //运行时的依赖
    "express-session": "^1.15.1"
  }
}
EOF

# 安装依赖包（两种情况）
# 安装运行时依赖
npm install ${MODULE_NAME} --save

# 安装开发时依赖
npm install ${MODULE_NAME} --save-dev
#    scripts配置可执行的命令，以 键值对 的方式配置，可配置多个
#    "script": {
#        "命令": "执行代码",
#        ...
#    }
# 执行配置的命令
# 必须加run
npm run 命令

# 特殊的命令 start 可不加run
npm start
#  或
npm run start

# 使用国内npm镜像源(3种方式)
# 使用配置：
npm config set registry ${s:="镜像源地址"}

# 使用cnpm：

# 先安装cnpm工具
npm install -g cnpm --registry=${s:="镜像源地址"}
# 使用cnpm代替npm
cnpm install ${MODULE_NAME}

# 使用nrm（推荐）：
# 1.先安装nrm工具
npm install -g nrm

# 2.查看当前可用的镜像源
nrm ls

# 3.切换npm源
nrm use 镜像源名称
