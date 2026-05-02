#!/data/data/com.termux/files/usr/bin/bash
cd $(dirname $0)
unset LD_PRELOAD
ROOTFS=~/termux-linux/ubuntu
proot \
--link2symlink \
-0 \
-r $ROOTFS \
-b /dev \
-b /proc \
-b /sys \
-b $ROOTFS/root:/dev/shm \
-w /root \
-b /data/data/com.termux/files/usr/tmp:/tmp \
/usr/bin/env -i \
HOME=/root \
PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games \
TERM=$TERM \
LANG=zh_CN.UTF-8 \
/bin/bash --login
