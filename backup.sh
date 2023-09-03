#!/bin/bash


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
