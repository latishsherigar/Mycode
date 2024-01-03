export PACKAGE_DIR=/home/latish/tally_attachment_emailer
export CWDIR=`pwd`

rm -fr $PACKAGE_DIR/*

mkdir $PACKAGE_DIR/artifacts
mkdir $PACKAGE_DIR/package
mkdir $PACKAGE_DIR/package/ui

cd tallyattachmentmailer
mvn clean install
cp target/tallyattachmentemailer-1.0.0-jar-with-dependencies.jar $PACKAGE_DIR/artifacts
cp target/classes/ui/* $PACKAGE_DIR/package/ui
#cp target/classes/config.ini $PACKAGE_DIR/package

cd $CWDIR/../eclipse1
cd ftphttpbridge
mvn clean package
cp target/ftphttpbridge-1.0.0.jar $PACKAGE_DIR/artifacts


cd $CWDIR
cd tallyattachmentemailer-licensevalidator
mvn clean install
cp target/licensevalidator-1.0.0-jar-with-dependencies.jar $PACKAGE_DIR/package
cp target/classes/run.txt $PACKAGE_DIR/package
cp target/classes/*.ini $PACKAGE_DIR/package
cp target/classes/*.gif $PACKAGE_DIR/package
chmod 777 $PACKAGE_DIR/package/*.sh

cd $CWDIR
cd tallyattachmentemailer-licensekeygenerator
mvn clean install
cp target/licensekeygenerator-1.0.0-jar-with-dependencies.jar $PACKAGE_DIR
cp target/classes/*.* $PACKAGE_DIR
rm -fr $PACKAGE_DIR/*.class
chmod 777 $PACKAGE_DIR/*.sh


