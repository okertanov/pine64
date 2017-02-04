#!/bin/bash
#
# Shell script to restart bluetooth
# RTL8723BS
#

echo "Re-initializing Pine64 Bluetooth Module"

killall /usr/bin/python3
killall obexd
killall rtk_hciattach
/etc/init.d/bluetooth stop

sleep 1

/usr/bin/python3 /usr/share/system-config-printer/applet.py &
/usr/bin/python3 /usr/bin/blueman-applet &
/etc/init.d/bluetooth start
/usr/bin/rtk_hciattach -n -s 115200 /dev/ttyS1 rtk_h5 > /tmp/hciattach.txt 2>&1 &
/bin/sleep 1
/usr/sbin/rfkill unblock all

echo "Pine64 Bluetooth Module Active"

