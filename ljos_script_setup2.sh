
cd ~/sources

begin=$(date +"%s")
echo "SCRIPT II -  LJOS"

nowis=$(date +"%s")
difftimelps=$(($nowis-$begin))
echo -e "`date`\t$difftimelps\t\tStarting LJOS Script II" >> ~/ljos_build.log

set +h
umask 022

export LJOS=~/ljos

echo $LJOS


nowis=$(date +"%s")
difftimelps=$(($nowis-$begin))
echo -e "`date`\t$difftimelps\t\tPlease follow manual instructions for clfs-embedded-bootscripts-1.0-pre5" >> ~/ljos_build.log

echo -n "Please follow manual instructions to clfs-embedded-bootscripts in another console then  press [ENTER]: "
read var_name


# tar -xf clfs-embedded-bootscripts-1.0-pre5.tar.bz2
# cd clfs-embedded-bootscripts-1.0-pre5

# make DESTDIR=${LJOS}/ install-bootscripts
# ln -sv ../rc.d/startup ${LJOS}/etc/init.d/rcS

# cd ../
# nowis=$(date +"%s")
# difftimelps=$(($nowis-$begin))
# echo -e "`date`\t$difftimelps\t\tLeaving embedded-bootscripts" >> ~/ljos_build.log


nowis=$(date +"%s")
difftimelps=$(($nowis-$begin))
echo -e "`date`\t$difftimelps\t\tUncompressing tar -xf zlib-1.2.11.tar.xz" >> ~/ljos_build.log

tar -xf zlib-1.2.11.tar.xz
cd zlib-1.2.11

sed -i 's/-O3/-Os/g' configure
./configure --prefix=/usr --shared
make && make DESTDIR=${LJOS}/ install

mv -v ${LJOS}/usr/lib/libz.so.* ${LJOS}/lib
ln -svf ../../lib/libz.so.1 ${LJOS}/usr/lib/libz.so
ln -svf ../../lib/libz.so.1 ${LJOS}/usr/lib/libz.so.1
ln -svf ../lib/libz.so.1 ${LJOS}/lib64/libz.so.1

cd ../
nowis=$(date +"%s")
difftimelps=$(($nowis-$begin))
echo -e "`date`\t$difftimelps\t\tLeaving zlib-1.2.11" >> ~/ljos_build.log

nowis=$(date +"%s")
difftimelps=$(($nowis-$begin))
echo -e "`date`\t$difftimelps\t\tInstalling the Target Image" >> ~/ljos_build.log

cd ${LJOS}

nowis=$(date +"%s")
difftimelps=$(($nowis-$begin))
echo -e "`date`\t$difftimelps\t\tCopyng ljos to ljos-copy" >> ~/ljos_build.log

#cp -rf ljos/ ljos-copy
cp -rf ${LJOS} ${LJOS}-copy

nowis=$(date +"%s")
difftimelps=$(($nowis-$begin))
echo -e "`date`\t$difftimelps\t\tCopyng ljos to ljos-copy COMPLETED" >> ~/ljos_build.log

rm -rfv ${LJOS}-copy/cross-tools
rm -rfv ${LJOS}-copy/usr/src/*

FILES="$(ls ${LJOS}-copy/usr/lib64/*.a)"
for file in $FILES; do
  rm -f $file
done


find ${LJOS}-copy/{,usr/}{bin,lib,sbin} -type f -exec sudo strip --strip-debug '{}' ';'
find ${LJOS}-copy/{,usr/}lib64 -type f -exec sudo strip --strip-debug '{}' ';'

sudo chown -R root:root ${LJOS}-copy
sudo chgrp 13 ${LJOS}-copy/var/run/utmp ${LJOS}-copy/var/log/lastlog
sudo mknod -m 0666 ${LJOS}-copy/dev/null c 1 3
sudo mknod -m 0600 ${LJOS}-copy/dev/console c 5 1
sudo chmod 4755 ${LJOS}-copy/bin/busybox


nowis=$(date +"%s")
difftimelps=$(($nowis-$begin))
echo -e "`date`\t$difftimelps\t\tcd jlos-copy && sudo tar cfJ ljos-build....tar.xz" >> ~/ljos_build.log

cd ${LJOS}-copy
sudo tar cfJ ../ljos-build-31July2018.tar.xz *

cd ../
sudo du -h|tail -n1

ls -lh ljos-*.tar.xz

cat /proc/partitions |grep sdd

sudo mkfs.ext4 /dev/sdd1
sudo mkdir tmp
sudo mount -t ext4 /dev/sdd1 ./tmp
cd tmp

sudo tar xJf ../ljos-build-31July2018.tar.xz
sudo grub-install --root-directory=/home/dinux/tmp/ /dev/sdd

nowis=$(date +"%s")
difftimelps=$(($nowis-$begin))
echo -e "`date`\t$difftimelps\t\tLJOS - Build Complete" >> ~/ljos_build.log
