#!/bin/bash
ffmpeg -y -threads 1 -hwaccel cuvid -c:v h264_cuvid -surfaces 16 -hwaccel_output_format cuda -i "$1" -map 0 -scodec copy -acodec copy -c:v h264_nvenc -surfaces 8 -preset slow -profile:v high -level 4.1 -map_metadata 0 -movflags use_metadata_tags -f matroska "$2"
