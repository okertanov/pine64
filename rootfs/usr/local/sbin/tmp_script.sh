#!/bin/sh -e
#
# rc.local
#
#This script is executed to resize the rootfs and it is execured only once after boot up
#

if [ -e /etc/rc.local_Ori ]; then
	/usr/local/sbin/resize_rootfs.sh
	mv /etc/rc.local_Ori /etc/rc.local
fi

rm -f "$0"

exit 0
