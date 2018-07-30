
mkdir -pv /mnt/sources
mkdir -pv /mnt/system
mkdir -pv /mnt/system/boot
mount -t ext4 /dev/sda3 /mnt/sources
mount -t ext4 /dev/sda2 /mnt/system
mount -t ext2 /dev/sda1 /mnt/system/boot

free -m
dd if=/dev/zero of=/mnt/system/swap.img bs=1024k count=1000
chmod 600 /mnt/system/swap.img
mkswap /mnt/system/swap.img
swapon /mnt/system/swap.img
free -m


chown -R xubuntu.xubuntu /mnt/sources
chown -R xubuntu.xubuntu /mnt/system

df -h
