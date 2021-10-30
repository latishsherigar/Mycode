#!/bin/bash

EXEDIR=`pwd`;

. /opt/jrxml2jasper/jrxml2jasper.sh $EXEDIR/

mv -f *.jasper ../../deploy/report_app/sdes/reports/
