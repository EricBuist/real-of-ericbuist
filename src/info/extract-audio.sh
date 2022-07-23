#!/bin/sh

mkdir mp3
mkdir mp3f
for i in `grep -l "audio/mpeg" *`; do mv $i mp3; done
cd mp3
for i in *; do strip-http.pl $i > ../mp3f/$i.mp3; done
cd ../mp3f
