#! /bin/bash

ALEXA_ROOT="/root/AlexaPi"

start() {
    echo "Starting Alexa..."
    exec > /var/log/alexa.log 2>&1
    python "$ALEXA_ROOT/main.py" &
}

stop() {
    echo "Stopping Alexa.."
    pkill -f "AlexaPi/main.py"
}

status() {
    pid=`pgrep -f "AlexaPi/main.py"`
    if [ -z "$pid" ]; then
      echo "AlexaPi is not running."
    else
      echo "AlexaPi is running (pid $pid)"
    fi
}

case "$1" in
  start)
      start
      ;;
  stop)
      stop
      ;;
  status)
      status
      ;;
  restart|force-reload)
      echo "Restarting Alexa.."
      stop
      sleep 2
      start
      echo "Restarted."
      ;;
  *)
      echo "Usage: $0 {start|stop|restart|status}"
      exit 1
esac

exit 0
