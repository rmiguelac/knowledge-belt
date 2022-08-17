#!/usr/bin/env bash

list_videos() {
	REC_VIDS=$(find ${RECS_FOLDER} -type f -name "*.mp4" -size +17M)
}

convert() {
	for v in ${REC_VIDS}; do
	    echo "[INFO] Converting ${v}"
        mv ${v} ${v/mp4/mpeg}
        # ADD A check to validate the mime
	    ffmpeg -loglevel quiet -i ${v/mp4/mpeg} -c copy ${v}
        if [ $? -eq 0 ]; then
            echo "[INFO] conversion done, deleting ${v/mp4/mpeg}"
            rm ${v/mp4/mpeg}
        fi
	done
}

main() {
	list_videos
	convert
}

main