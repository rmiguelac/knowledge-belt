# Video

## Table of contents

* [Cut video from min X to min Y](#cut-video-from-min-x-to-min-y)  
* [Convert to mp4](#convert-to-mp4)
* [Create gif from video](#create-gif-from-video)
* [Take screenshot from last frame](#take-screenshot-from-last-frame)
---

### **Cut video from min X to min Y**

```bash
# Get total seconds
SECS=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 x.mp4)

# Transform seconds into hh:mm:ss format
date -d@${SECS} -u +%H:%M:%S 

# Actual cut from the start to minute 2 and 20 seconds
ffmpeg -i x.mp4 -ss 00:00:00 -to 00:02:20 -c:v copy -c:a copy output.mp4
```

### **Convert to mp4**

```
ffmpeg -loglevel quiet -i input.mpeg -c copy output.mp4

```

### **Create gif from video**

```
ffmpeg -r 640 -i VIDEO.mp4 -vf "fps=10,scale=320:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 output.gif
```

Where `-r` is the frequency, meaning how fast it is.

To cut it in the first X seconds, add `-t X` to the command.

### **Take screenshot from last frame**

```
ffmpeg -sseof -3 -i ipnut.mp4 -vsync 0 -q:v 31 -update true out.jpg
```
