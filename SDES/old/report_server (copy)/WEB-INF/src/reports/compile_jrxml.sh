#!/bin/bash

EXEDIR=`pwd`;

. /opt/jrxml2jasper/jrxml2jasper.sh $EXEDIR/

mkdir jasper
mv -f *.jasper jasper
