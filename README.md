# shell-tools
Shell tools for Linux automation (CentOS and Raspbian primary)


## Verifications and one-liners

### Find Raspbian changed files
`dpkg --verify` -> `dpkg --verify | awk '{print $3;}' | xargs dpkg -S` - for configs

## Video transcode @ Win 10 ffmpeg
CUDA supporting build is from https://www.gyan.dev/ffmpeg/builds/
### 1080p Normal HQ with CUDA from BD
`ffmpeg -y -threads 1 -hwaccel cuvid -c:v h264_cuvid -surfaces 16 -hwaccel_output_format cuda -i <in> -map 0 -scodec copy -acodec copy -c:v h264_nvenc -surfaces 64 -preset p7 -profile:v high -level 4.1 -b:v 5M -map_metadata 0 -movflags use_metadata_tags -f <out>`
### Resize `$2` to `$1` Keep audio (DTS for example), lower video bitrate with CUDA, save as `$3`
`ffmpeg -y -hwaccel cuvid -hwaccel_output_format cuda -i "$2" -map 0 -scodec copy -acodec copy -vf scale_cuda=-2:$1 -c:v h264_nvenc -preset slow -profile:v high -level 4.1 -map_metadata 0 -movflags use_metadata_tags -f matroska "$3"`
### Same with Intel QSV with Intel video on Laptop
`ffmpeg -y -hwaccel qsv -hwaccel_output_format qsv -c:v h264_qsv -i "$2" -map 0 -map -0:7 -scodec copy -acodec copy -vf scale_qsv=-1:"$1" -c:v h264_qsv -preset slow -profile:v high -b:v 2M -map_metadata 0 -movflags use_metadata_tags -f matroska "$3"`
