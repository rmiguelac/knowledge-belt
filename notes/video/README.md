### **Cut video from min X to min Y**

```bash
# Get total seconds
ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 x.mp4

# Transform seconds into hh:mm:ss format
date -d@263.356333 -u +%H:%M:%S 

# Actual cut from the start to minute 2 and 20 seconds
ffmpeg -i x.mp4 -ss 00:00:00 -to 00:02:20 -c:v copy -c:a copy output.mp4
```