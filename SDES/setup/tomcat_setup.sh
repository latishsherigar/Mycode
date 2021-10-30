#!/bin/sh
# ./tomcat_setup.sh app_name proj_dir clean_deploy db_name proj_name
# ./tomcat_setup.sh report_server ~/my_projects/SDES/tomcat/report_server Y report_server
#
DEPLOY_DIR="/opt/apache-tomcat-6.0.7/webapps"
APP_DIR=$DEPLOY_DIR/$1
PROJ_DIR=$2/deploy/*
SOURCE_CODE_DIR=$2/src
CLEAN_DEPLOY=$3
TEMP_PROJ_DIR=temp/tomcat/$1
DB_NAME=$4
DB_USER=$5
DB_PASS=$6


#replace custom variables
rm -fr $TEMP_PROJ_DIR
mkdir $TEMP_PROJ_DIR
cp -ur $PROJ_DIR $TEMP_PROJ_DIR

for j in `cat $SOURCE_CODE_DIR/variables.lst`
do
 sed -i "s/%DB_NAME%/$DB_NAME/g" $TEMP_PROJ_DIR/$j
 sed -i "s/%DB_USER%/$DB_USER/g" $TEMP_PROJ_DIR/$j 
 sed -i "s/%DB_PASS%/$DB_PASS/g" $TEMP_PROJ_DIR/$j 
done

if [ "$CLEAN_DEPLOY" = "Y" ]; 
then
  echo 'Cleaning....';
  rm -fr $APP_DIR;
  mkdir $APP_DIR;
  echo 'done.';
fi

cp -ur $TEMP_PROJ_DIR/* $APP_DIR

chown -R latish $APP_DIR
