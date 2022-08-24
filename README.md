# shell-tools
Shell tools for Linux automation (CentOS and Raspbian primary)


## Verifications and one-liners

### Find Raspbian changed files
`dpkg --verify` -> `dpkg --verify | awk '{print $3;}' | xargs dpkg -S` - for configs
### First 2 rows are some numbers (bitrate and file size), print if value more than something
`awk '($1 > 5000) {for (i=3; i<=NF; i++) { printf $i " "} ; print LF;}' dirlist.sorted.txt`

## Video transcode @ Win 10 ffmpeg
CUDA supporting build is from https://www.gyan.dev/ffmpeg/builds/
```
16:9 aspect ratio
    2160p: 3840x2160
    1440p: 2560x1440
    1080p: 1920x1080
    720p: 1280x720
    480p: 854x480
    360p: 640x360
    240p: 426x240
Named
    VGA 640 x 480
    SD Video 768 576
    SVGA 800 x 600
    XGA 1024 x 768
    SXGA 1280 x 1024
    HD Video (720) 1280 x 720
    WXGA 1366 x 768
    WSXGA 1440 x 900
    SXGA+ 1400 x 1050
    UXGA 1600 x 1200
    WSXGA+ 1680 x 1050
    HD Video (1080 or Full HD) 1980 x 1080
    WUXGA 1920 x 1200
    WQXGA 2560 x 1600
```
#### Shortcuts
* `-c:2 ac3 -b:2 448k` - encode stream 2 of output into AC3 (from DTS)
* `-c:a dca` - encode to DTS (from something really HD in 4K)

### 1080p Normal HQ with NVidia CUDA from BD
`ffmpeg -y -threads 1 -hwaccel cuvid -c:v h264_cuvid -surfaces 16 -hwaccel_output_format cuda -i <in> -map 0 -scodec copy -acodec copy -c:v h264_nvenc -surfaces 64 -preset p7 -profile:v high -level 4.1 -b:v 5M -map_metadata 0 -movflags use_metadata_tags -f <out>`

`-vf "scale_cuda=-2:480:force_original_aspect_ratio=2:force_divisible_by=2"` - scale video by NVidia to 480 by height, keep proportions as much it can (DAR, SAT starting dancing here)
#### Copy all, drop stream 5
`ffmpeg -y -threads 1 -hwaccel cuvid -c:v h264_cuvid -surfaces 16 -hwaccel_output_format cuda -i <src> -map 0:v -map 0:a -map 0:s -map -0:5 -c:s copy -c:a copy -c:v h264_nvenc -surfaces 64 -preset p7 -profile:v high -level 4.1 -b:v 4M  -bufsize 70M -map_metadata 0 -movflags use_metadata_tags -f matroska <dst>`
#### Resize `$2` to `$1` Keep audio (DTS for example), lower video bitrate with CUDA, save as `$3`
`ffmpeg -y -hwaccel cuvid -hwaccel_output_format cuda -i "$2" -map 0 -scodec copy -acodec copy -vf scale_cuda=-2:$1 -c:v h264_nvenc -preset slow -profile:v high -level 4.1 -map_metadata 0 -movflags use_metadata_tags -f matroska "$3"`

### Same with Intel QSV with Intel video on Laptop - looks like Video Quality better than NV CUDA
`ffmpeg -y -hwaccel qsv -hwaccel_output_format qsv -c:v h264_qsv -i "$2" -map 0 -map -0:7 -scodec copy -acodec copy -vf scale_qsv=-1:"$1" -c:v h264_qsv -preset slow -profile:v high -b:v 2M -map_metadata 0 -movflags use_metadata_tags -f matroska "$3"`

It has some probles with auto scaling. Sometimes giving green bar of 10 pixels on bottom or it could be some trash bar. Calculate dimensions manually for most cases. For h264 it is important to keep sizes in pixels even (divisible by 2) on both sides.
#### Lover 4K HDR HEVC to H264 + DTS (no auto rescaling)
`ffmpeg -y -hwaccel qsv -hwaccel_output_format qsv -c:v hevc_qsv -i <in> -map 0 -map -0:9 -map -0:3 -map -0:2 -scodec copy -c:a dca -vf "scale_qsv=format=nv12:w=1382:h=576" -c:v h264_qsv -preset slow -profile:v high -b:v 2M -map_metadata 0 -movflags use_metadata_tags -f matroska <out>`

`scale_qsv=format=nv12` - here helping to conver HDR pixel format to something readable by H264 and Dune HD
