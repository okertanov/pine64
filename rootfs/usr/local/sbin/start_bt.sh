#!/bin/bash
#
# Shell script to install Bluetooth firmware and attach BT part of
# RTL8723BS
#

echo "Initializing Pine64 Bluetooth Module"

/usr/bin/rtk_hciattach -n -s 115200 $1 rtk_h5 > /tmp/hciattach.txt 2>&1 &
/bin/sleep 5
/usr/sbin/rfkill unblock all
/bin/sleep 5
/etc/init.d/bluetooth start

echo "Pine64 Bluetooth Module Active"
