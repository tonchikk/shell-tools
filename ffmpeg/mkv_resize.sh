#!/bin/bash
ffmpeg -y -hwaccel cuvid -hwaccel_output_format cuda -i "$2" -map 0 -scodec copy -acodec copy -vf scale_cuda=-2:$1 -c:v h264_nvenc -preset slow -profile:v high -level 4.1 -map_metadata 0 -movflags use_metadata_tags -f matroska "$3"
