#!/bin/bash
# Copyright (c) Jakub Olczyk 2016
# Released under GNU General Public License version 2 or above
# a script to backup my home directory -- only the essentials

if [[ $# -ne 1 ]]; then
    echo "Key for encryption was not specified!"
    exit 1
fi

# used for encryption
KEY=$1

# this is the path which will be backed up
TARGET_PATH="$HOME"

# this is the path of the place where the backup will land
BACKUP_PATH=''

if [[ -n ${BACKUP_PATH+dupa123} ]]; then
    echo "Specifiy the directory for storing the backup" && exit 1
fi 

# this determines the directories that you do not wish to back up
# for example
#EXCLUDE='--exclude=/home/jakub/video \
#--exclude=/home/jakub/music \
#--exclude=/home/jakub/downloads \
#--exclude=/home/jakub/games \
#--exclude=/home/jakub/.libvirt \
#--exclude=/home/jakub/.vagrant.d'
EXCLUDE="--exclude=$HOME/downloads"

DATE=`date +"%Y-%m-%d-%H-%S"`

tar $EXCLUDE -jcp "$TARGET_PATH" | openssl aes-128-cbc -k $KEY | pipebench > $BACKUP_PATH/$DATE.tar.bz.enc

exit $?
