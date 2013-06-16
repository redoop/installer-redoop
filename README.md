rosi: Redoop Operating System Installer
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This file is a logbook of "rosi" development from the more
early phases.

- Project kick-off

Originally this installer was based on Anaconda installer, 
from Fedora 10 branch:

$ cat /etc/fedora-release 
Fedora release 10 (Cambridge)

$ git clone git://git.fedorahosted.org/git/anaconda.git anaconda.git
$ git checkout --track -b f10-branch origin/f10-branch

- Minimal packages in Fedora based distro:

$ yum install libnl-devel isomd5sum-devel NetworkManager-devel audit-libs-devel squashfs-tools

- Minimal packages in Ubuntu based distro:

$ sudo apt-get install \
	network-manager-dev libdbus-1-dev libnl1 libnl-dev libpopt-dev e2fslibs-dev \
	libzip-dev libdevmapper-dev libblkid-dev libaudit-dev python-dev \
	libnewt-dev policycoreutils dracut grub hal libsqlite3-dev squashfs-tools \
	python-newt python-parted libx11-dev libdmraid-dev 

- Instructions:

$ cd anaconda.git 
$ make -C isys/
$ make -C loader/

#
# Early phase-0
#

====> 0. The installation process:

POS BIOS/
    |-- isolinux boot monitor
    |-- stage-1: init
    |-- stage-1: loader
    `-- stage-2: a-installer

====> 1. stage-1/init and stage-1/loader are just from anaconda sources

$ make -C isys/ && make -C stage-1/

====> 2. Bootdisk creation: isolinux

bootdisk/
`-- isolinux
    |-- isolinux.cfg
    `-- splash.jpg

$ sh create-bootdisk.sh

bootdisk/
`-- isolinux
    |-- isolinux.bin ==> just from tarball in binary format
    |-- isolinux.cfg
    |-- splash.jpg
    `-- vesamenu.c32 ==> just from tarball in binary format

Note about vesamenu.c32:

com32/modules/vesamenu.c32 (graphical) 
com32/modules/menu.c32 (text only menu)

With vesamenu.c32 we can use a background image normally 640x480
pixels and either in PNG, JPEG or LSS16 format.

We can use the binary files from the native package of development workstation. In
Fedora 10:

$ rpm -ql syslinux | grep -E "isolinux.bin|vesamenu.c32" 
/usr/lib/syslinux/isolinux.bin
/usr/lib/syslinux/vesamenu.c32

====> 3. Bootdisk creation: initrd

First of all, we're going to use the native binaries of the development
workstation (Fedora 10). Later, we'll use the built binaries from OE.

Note: loader binary dependences (in dev workstation Fedora 10)

newt-0.52.10-2.fc10.i386
slang-2.1.4-1.fc10.i386
zlib-1.2.3-18.fc9.i386
popt-1.13-4.fc10.i386
device-mapper-libs-1.02.27-6.fc10.i386 ==> LVM2 userspace device-mapper support library (libdevmapper)
libnl-1.1-5.fc10.i386 ==> library for kernel netlink sockets
dbus-libs-1.2.4-1.fc10.i386
libselinux-2.0.73-1.fc10.i386 ==> SELinux library and simple utilities
libsepol-2.0.33-1.fc10.i386 ==> SELinux binary policy manipulation library
libcap-2.10-2.fc10.i386 ==> Library for getting and setting POSIX.1e capabilities


#
# Early phase-1
#


--
  Javi Roman <javiroman@redoop.org>



