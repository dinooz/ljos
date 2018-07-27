# Ubuntu - Required Dependencies to compile LJOS [ Linux Journal OS ]
# sudo ./ljos_get_desp.sh


apt -y install gcc
apt -y install make
apt -y install libncurses5-dev
apt -y install libncursesw5-dev
apt -y install grub-efi-amd64

apt -y install g++
apt -y install bison
apt -y install flex
apt -y install libgmp3-dev
apt -y install libmpfr-dev libmpfr-doc libmpfr4 libmpfr4-dbg
apt -y install mpc
apt -y install texinfo
apt -y install libcloog-isl-dev

apt -y install m4
apt -y install makeinfo
apt -y install gawk
apt -y install automake

apt -y install autoconf
apt -y install build-essential
apt -y install libelf-dev
apt -y install libssl-dev

dpkg-reconfigure dash
