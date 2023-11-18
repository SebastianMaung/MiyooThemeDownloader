#!/bin/sh
echo $0 $*
cd $(dirname "$0")
touch /tmp/stay_awake
st -q -e sh /mnt/SDCARD/App/themestore/conv
#sleep 5
echo $0 $*
cd $(dirname "$0")
HOME=/mnt/SDCARD/dir
HOME=.
./mnt/SDCARD/App/themestore/DinguxCommander
sh /mnt/SDCARD/App/Commander_Italic/launch.sh
sync
st -q -e sh /mnt/SDCARD/App/themestore/get
echo $0 $*
cd /mnt/SDCARD/.tmp_update
./bin/themeSwitcher
