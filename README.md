# lossless-cut
Shell script to cut media files. It's extremely fast and it completely preserves the quality of the original file. Based on FFmpeg.

## Parameters
The media file path and the cut points file using FFmpeg's time duration syntax (https://ffmpeg.org/ffmpeg-utils.html#time-duration-syntax)

## Example
```
./cut.sh video_file.mp4 points.txt
```
where 'points.txt' contains:
```
1:23:04
1:40:25
2:10:12
2:14:53
```

'output.mp4' will include 'video_file.mp4' from 1:23:04 to 1:40:25 and from 2:10:12 to 2:14:53.

## Special values
'0' means 'from the start' and not indicating an endpoint for the final fragment means 'until the end'. For example,
```
0
24:02
1:06:44
```
means from the start until 24:04 and from 1:06:44 until the end.

## Note
Due to codec limitations, some fragments may start a few seconds sooner than specified.

## Subtitles
In order to include some default subtitles, the command line parameters would be:
```
ffmpeg -i video_file.mkv -i subtitles_file.srt -c copy -disposition:s:0 default output.mkv
```
