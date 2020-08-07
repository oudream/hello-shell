#!/usr/bin/env bash

# org
# https://github.com/nvm-sh/nvm

### install
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

nvm --version

nvm ls-remote --lts

nvm install 6.10.2
nvm install 10.22.0

nvm list
nvm ls

nvm use 6.10.2
nvm use 10.22.0

# 察看目前使用版本
nvm current


cat > /opt/hello-timer1.js <<EOF
let _times = 0;
function myFunc() {
    _times ++;
    console.log("current time => ", (new Date()).toISOString(), ", current Node Version => ", process.version);
    if (_times > 60 * 5) {
        clearInterval(_interval);
        process.exit(0);
    }
}
let _interval = setInterval(myFunc, 1000);
EOF

nvm exec 6.10.2 node /opt/hello-timer1.js
nvm exec 10.22.0 node /opt/hello-timer1.js

[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target

[Service]
Type=forking
User=root

# Clean any existing files in /tmp/.X11-unix environment
ExecStartPre=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'
ExecStart=/usr/sbin/runuser -l root -c "/usr/bin/vncserver %i -geometry 1600x1024"
PIDFile=/home/root/.vnc/%H%i.pid
ExecStop=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'

[Install]
WantedBy=multi-user.target