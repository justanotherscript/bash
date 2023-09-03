#!/bin/bash


mountDisk() {
    read -s -p "Password: " password
    echo -e "$password\n" | cryptsetup open /dev/sdb1 crypt
    mount /dev/mapper/crypt /mnt
}


unmountDisk() {
    umount -R /mnt
    cryptsetup close crypt
}


help() {
    echo Args: mount, unmount, help
}


if [ $# -eq 1 ]; then
    if [ $1 == "mount" ]; then
        mountDisk
    elif [ $1 == "unmount" ]; then
        unmountDisk
	elif [ $1 == "help" ]; then
		help
	else
		echo Unknown argument, use \"help\"
	fi
else
    help
fi
