#!/usr/bin/env bash


pm2 restart app_name
pm2 reload app_name
pm2 stop app_name
pm2 delete app_name


### isntall
npm install pm2 -g

# start
pm2 start app.js

pm2 list
pm2 ls
pm2 status

# Managing apps is straightforward:
pm2 stop     <app_name|namespace|id|'all'|json_conf>
pm2 restart  <app_name|namespace|id|'all'|json_conf>
pm2 delete   <app_name|namespace|id|'all'|json_conf>

# To have more details on a specific application:
pm2 describe <id|app_name>

# To monitor logs, custom metrics, application information:
pm2 monit

# To consult logs just type the command:
pm2 logs
pm2 logs APP-NAME       # Display APP-NAME logs 
pm2 logs --json         # JSON output 
pm2 logs --format       # Formated output 
pm2 flush               # Flush all logs
pm2 reloadLogs          # Reload all logs 


# PM2设置开机自启动
# Init Systems Supported: systemd, upstart, launchd, rc.d
# Generate Startup Script
pm2 startup


# 将当前pm2所运行的应用保存在/root/.pm2/dump.pm2下，当开机重启时，运行pm2-root服务脚本，并且到/root/.pm2/dump.pm2下读取应用并启动
# Freeze your process list across server restart
pm2 save


# Remove Startup Script
pm2 unstartup


# 例子
cat > twant-h5.json <<EOF
{
  "name" : "twant-h5",
  "script" : "/usr/oudream/twant/node_modules/.bin/nuxt",
  "args" : "start",
  "cwd" : "/usr/oudream/twant",
  "interpreter" : "/usr/oudream/node10/bin/node",
}
EOF
pm2 start twant-h5.json
