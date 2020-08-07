#!/usr/bin/env bash

### centos
sudo yum -y install wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
# sudo yum -y install ./google-chrome-stable_current_*.rpm
google-chrome –version
# CentOS 下如果使用上述的方式安装，安装时没问题，但真实调用时，会出现 Chromium 缺少依赖项的报错，通过安装以下依赖可以解决。
#依赖库
sudo yum -y install pango.x86_64 libXcomposite.x86_64 libXcursor.x86_64 libXdamage.x86_64 libXext.x86_64 libXi.x86_64 \
 libXtst.x86_64 cups-libs.x86_64 libXScrnSaver.x86_64 libXrandr.x86_64 GConf2.x86_64 alsa-lib.x86_64 atk.x86_64 gtk3.x86_64
# 中文字体
sudo yum -y install ipa-gothic-fonts xorg-x11-fonts-100dpi xorg-x11-fonts-75dpi xorg-x11-utils xorg-x11-fonts-cyrillic \
 xorg-x11-fonts-Type1 xorg-x11-fonts-misc


### doc
# Run Chromium with flags:
# http://www.chromium.org/developers/how-tos/run-chromium-with-flags
# List of Chromium Command Line Switches:
# http://peter.sh/experiments/chromium-command-line-switches/
# https://superuser.com/questions/545033/google-chrome-command-line-switches
# https://source.chromium.org/chromium/chromium/src/+/master:headless/app/headless_shell_switches.cc?originalUrl=https:%2F%2Fcs.chromium.org%2F


###
# https://developers.google.com/web/updates/2017/04/headless-chrome

# Printing the DOM
# The --dump-dom flag prints document.body.innerHTML to stdout:
chrome --headless --disable-gpu --dump-dom https://www.chromestatus.com/

# Create a PDF
# The --print-to-pdf flag creates a PDF of the page:
chrome --headless --disable-gpu --print-to-pdf https://www.chromestatus.com/