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


# Init Systems Supported: systemd, upstart, launchd, rc.d
# Generate Startup Script
pm2 startup

# Freeze your process list across server restart
pm2 save

# Remove Startup Script
pm2 unstartup
