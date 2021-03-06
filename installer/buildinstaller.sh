#!/bin/bash
#
# mk-installer.sh
#
# Copyright (C) 2013 Comodoo.org  All rights reserved.
# Javi Roman <javiroman@comodoo.org>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
# Minimal utilities for this tool.
# tree, mksquashfs, mkisofs
#


# FIXME:
# Only we can run being superuser, by now.

#[ `id -u` != "0" ] && echo "You must be root!" && exit

usage () {
    echo "usage: mk-installer.sh [<cleanall>]"
	exit 0
}

cleanall () {
    rm cd.iso
    rm c.img


    make -C isys clean
    make -C stage-1 clean
    make -C pyblock clean

    rm -fr CD

    rm -fr /tmp/comodoo-*
    rm -fr /tmp/dir
    rm -fr /tmp/instimage*
    rm -fr /tmp/keepfile.*

    rm yocto/bzImage-romley.bin  
    rm yocto/core-image-comodoo-romley.tar.gz  
    rm yocto/modules.tar.gz

    rm -fr logs

    exit 0
}

clean () {
    rm -fr /tmp/a-i* /tmp/instimage.*
    rm -fr CD/
    rm -f /tmp/keepfile*
    rm -fr /tmp/dir
    exit 0
}

#
# Main
#

while [ $# -gt 0 ]; do
    case $1 in
        --debug)
            DEBUG="--debug"
            shift
            ;;
        --clean)
            clean
            ;;
        --cleanall)
            cleanall
            ;;
        --buildall)
            break
            ;;
        *)
            usage
            ;;
    esac
done

#
# syslinux related stuff.
#
./_mk-bootdisk.sh
[ $? = 1 ] && echo "ERROR Undefined, _mk-cdrom and _run-install skipped" && exit 1

#
# final ISO cd image.
#
./_mk-cdrom.sh CD

#
# run qemu installer
#
./_run-install.sh 

# vim: ts=4:sw=4:et:sts=4:ai:tw=80
