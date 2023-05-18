#! /bin/bash
APP_NAME='DOGEINLOOP'
APP_PATH=/root/xmrig-6.18.1/doge.sh
pid_file=/root/xmrig-6.18.1/thread.pid

RUNNING=0
if [ -f $pid_file ]; then
    pid=`cat $pid_file`
    if [ "x$pid" != "x" ] && kill -0 $pid 2>/dev/null; then
        RUNNING=1
    else
        echo "Service $APP_NAME is not running"
    fi
fi

start()
{
    if [ $RUNNING -eq 1 ]; then
        echo "Service $APP_NAME already started (pid $pid)"
    else
        echo "Service $APP_NAME begin to start"
        $APP_PATH &
        echo $! > $pid_file
        if [ -f $pid_file ]; then
		    pid=`cat $pid_file`
		fi
        echo "Service $APP_NAME started (pid $pid)"
    fi
}

stop()
{
    if [ $RUNNING -eq 1 ]; then
        kill -9 $pid
        echo "Service $APP_NAME stopped"
    else
        echo "Service $APP_NAME not running"
    fi
}

restart()
{
    stop
    start
}

case "$1" in

    'start')
        start
        ;;

    'stop')
        stop
        ;;

    'restart')
        restart
        ;;

    *)
        echo "Usage: $0 {  start | stop | restart  }"
        exit 1
        ;;
esac

exit 0
