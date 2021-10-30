#!/bin/sh
# ./setup.sh dbname html_web_dir html_sys_dir proj_dir dbsetup clean_deploy DB_USER DB_PASS report_server
# ./setup.sh SDES sdes sdes /home/latish/my_proj/sdes 'N'
#
HTML_DIR="/var/www/html"
PROJ_DIR=$4/deploy/*
SOURCE_CODE_DIR=$4/src
DB_SETUP=$5
CLEAN_DEPLOY=$6
TEMP_PROJ_DIR=temp/www/$3
DB_NAME=$1
DB_USER=$7
DB_PASS=$8
REPORT_SERVER=$9


#replace custom variables
rm -fr $TEMP_PROJ_DIR
mkdir $TEMP_PROJ_DIR
cp -ur $PROJ_DIR $TEMP_PROJ_DIR

for j in `cat $SOURCE_CODE_DIR/variables.lst`
do
 sed -i "s/%DB_NAME%/$DB_NAME/g" $TEMP_PROJ_DIR/$j
 sed -i "s/%DB_USER%/$DB_USER/g" $TEMP_PROJ_DIR/$j 
 sed -i "s/%DB_PASS%/$DB_PASS/g" $TEMP_PROJ_DIR/$j 
 sed -i "s/%REPORT_SERVER%/$REPORT_SERVER/g" $TEMP_PROJ_DIR/$j  
 sed -i "s/%DB_HOST%/$DB_HOST/g" $TEMP_PROJ_DIR/$j  
done



if [ "$DB_SETUP" = "Y" ]; 
then
  echo 'Starting DB setup....';
  mysql $1 --user root -f <formst3_script.sql> a.out;
  mysql $1 --user root -f <bill_printer_script.sql> b.out;
  wget http://localhost/$2/bill_printer/invoice_move_stag_data.php -O c.out -o d.out;
  echo 'done.';
fi

if [ "$CLEAN_DEPLOY" = "Y" ]; 
then
  echo 'Cleaning....';
  rm -fr $HTML_DIR/$3;
  mkdir $HTML_DIR/$3;
  echo 'done.';
fi

cp -ur $TEMP_PROJ_DIR/* $HTML_DIR/$3

chown -R latish $HTML_DIR/$3
