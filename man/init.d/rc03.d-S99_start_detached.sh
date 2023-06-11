#!/bin/sh

### BEGIN INIT INFO
# Provides:          myservice
# Required-Start:    $local_fs $remote_fs $network $time
# Required-Stop:     $local_fs $remote_fs $network $time
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: My Service
# Description:       This is my service.
### END INIT INFO

case "$1" in
  start)
    /userdata/detached 1>/userdata/detached.log 2>&1 &
    echo "S99_start_detached start $(date)" >> /userdata/auto_start.log
    echo "Starting myservice"
    # Start myservice here
    ;;
  stop)
    echo "Stopping myservice"
    # Stop myservice here
    ;;
  restart)
    echo "Restarting myservice"
    # Restart myservice here
    ;;
  status)
    echo "Status of myservice"
    # Check the status of myservice here
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|status}"
    exit 1
    ;;
esac

exit 0
