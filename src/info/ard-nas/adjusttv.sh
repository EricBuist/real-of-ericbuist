#!/bin/sh

# Ceci permet de faire entrer environ 2 heures et demi sur 4Go
v4l2-ctl -cvideo_bitrate=3817748,video_peak_bitrate=4000000
# À peu près 2476Mo par heure
#v4l2-ctl -cvideo_bitrate=4800000,video_peak_bitrate=6000000
# À peu près 1024Mo par heure
#v4l2-ctl -cvideo_bitrate=2350000,video_peak_bitrate=3000000
# Type de flux: DVD
v4l2-ctl -cstream_type=3
# Volume maximal pour le son, ah c'est peut-être ça qui cause problème!
v4l2-ctl -cvolume=65535
