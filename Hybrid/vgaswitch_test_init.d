#!/bin/sh
### BEGIN INIT INFO
# Provides:          vgaswitch
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Power on second videocard to fix errors on shutdown.
# Description: Place this file under /etc/init.d/vgaswitch and run "update-rc.d vgaswitch defaults".
### END INIT INFO
 
# Do NOT "set -e"
 
# PATH should only include /usr/* if it runs after the mountnfs.sh script
PATH=/sbin:/usr/sbin:/bin:/usr/bin
 
case "$1" in
  start)
	usr/local/bin/vgaswitch off
  ;;
  stop)
	/usr/local/bin/vgaswitch on
	;;
esac
 
:
