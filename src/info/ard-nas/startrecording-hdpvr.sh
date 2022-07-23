#!/bin/sh

if [ $# -lt 3 ]; then
	echo "Usage: startrecording-hdpvr outputfile duration-in-seconds startTime"
	exit 1
fi

OUTPUT=$1
shift
DURATION=$1
shift
START=$*

DIR=`dirname "$0"`
echo python3 $DIR/safecp.py /dev/video0 \"$OUTPUT\" $DURATION | at $START


