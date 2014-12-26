#!/bin/sh

# Linux FTP Backup Script
# Version: 1.0
# Script by: Pietro Marangon
# Skype: pe46dro
# Email: pietro.marangon@gmail.com

########################
# Edit Below This Line #
########################

# FTP Login Data
USERNAME="USERNAME HERE"
PASSWORD="PASSWORD HERE"
SERVER="IP HERE"

#Directory where thing to backup is located
DIR="/root"

#Remote directory where the backup will be placed
REMOTEDIR="./"

#Filename of backup file to be transfered DON'T WRITE EXTENSION (.tar/.zip/ecc...)
FILE="BACKUP_NAME"

#Transfer type
#1=FTP
#2=SFTP
TYPE=1

#Date type
#1=Daily
#2=Less than an hour
DTYPE=1



##############################
# Don't Edit Below This Line #
##############################

if [ $DTYPE -eq 1]
then
d=$(date --iso)

if [ $DTYPE -eq 2]
then
d=$(date '+%d-%m-%Y_%H_%M')



if [ $TYPE -eq 1 ]
then
FILE=$FILE"_"$d".tar.gz"
tar -czvf ./$FILE $DIR
echo 'Tar Complete'
ftp -n -i $SERVER <<EOF
user $USERNAME $PASSWORD
binary
put $FILE $REMOTEDIR/$FILE
quit
EOF
echo 'External Backup Complete'
rm -f $FILE
echo 'Localy backup removed'
elif [ $TYPE -eq 2 ]
then
echo "Please use FTP, SFTP isn't supported"
else
echo "Please select a valid type"
fi
#END
