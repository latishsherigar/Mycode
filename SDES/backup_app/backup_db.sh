#!/bin/sh

#Author : Latish Sherigar
#email: latishsherigar@yahoo.co.in

#Desc: A mysql db back up script.
#      Takes a full back only if the db
#      contents has been changed 
#

DB_NAME='SDES'
DB_BACKUP_DIR=/opt/sdes/backup/db/$DB_NAME

filename=`date +%s`
tmpfilepath=$DB_BACKUP_DIR/data/tmp/$filename


if [ -d $DB_BACKUP_DIR ]
then
  echo 'Backup DB Directory exists.'
else
  echo 'Creating required directories....'
  mkdir -p $DB_BACKUP_DIR/data/tmp
  mkdir -p $DB_BACKUP_DIR/latest
fi

#dump mysql data
mysqldump -u root $DB_NAME>$tmpfilepath

file_updated=1

#create a dummy db_dump  file when run for the 1st time
if [ -f $DB_BACKUP_DIR/latest/db_dump ]
then
 echo 'Latest file exists...'
 latestfilename=`cat $DB_BACKUP_DIR/latest/latestfilename`
 #unzip the latest file for comparison
 unzip $DB_BACKUP_DIR/latest/db_dump -d $DB_BACKUP_DIR/data/tmp/
 #compare the latest and the one generated
 file_updated=`cmp $DB_BACKUP_DIR/data/tmp/$latestfilename $tmpfilepath|wc -c`
fi

if [ $file_updated -eq 0 ]
then
   echo 'DB file unchanged'
else
   echo 'DB file changed'
   #mv $tmpfilepath $tmpfilepath'.data'
   zip -j $tmpfilepath'.zip' $tmpfilepath
   mv $tmpfilepath'.zip' $DB_BACKUP_DIR/data/
   rm -f $DB_BACKUP_DIR/latest/db_dump
   ln -s $DB_BACKUP_DIR/data/$filename'.zip' $DB_BACKUP_DIR/latest/db_dump
   echo $filename>$DB_BACKUP_DIR/latest/latestfilename
   latestfilename=`cat $DB_BACKUP_DIR/latest/latestfilename`

fi

   echo 'Cleaning up....'
   rm -fr $DB_BACKUP_DIR/data/tmp/*

   echo 'Latest Backup : ' $latestfilename'.zip'
