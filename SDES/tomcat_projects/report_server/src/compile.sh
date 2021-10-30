#!/bin/sh

echo 'Compiling Java files...' 
javac -d ../deploy/WEB-INF/classes ReportEngine.java 
echo 'done.' 

cd reports 
echo 'Compiling Jasper files...' 
./compile_jrxml.sh
echo 'done.' 

