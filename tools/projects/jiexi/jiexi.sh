
/userdata/dgri/tk5srv/tk5srv -d /userdata/dgri/tk5srv 1> /dev/null 2>/dev/null &

nohup /opt/tk/hello_iec104/projects/tkiec104_web/deploy/tk5web -d "/opt/tk5web" 1> /var/log/tk5web.log 2>&1 &

