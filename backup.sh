#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root." 1>&2
	exit 1
fi

# Variables
BACKUP_DIR = '/backups'
TIME = `date +%m-%d-%Y_%H:%M`


# Make dir for backups if not exist
if [ ! -d "$BACKUP_DIR" ];
then
    mkdir "$BACKUP_DIR"
fi


# Backup all MySQL databases
mysqldump --all-databases > $BACKUP_DIR/$TIME/mysql_backup.dump


# Make Archive
zip -m $BACKUP_DIR/$TIME.zip $BACKUP_DIR/$TIME
