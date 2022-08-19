#!/usr/bin/env bash

list_videos() {
	if [ -d $1 ]; then
		REC_VIDS=$(find ${RECS_FOLDER} -type f -name "*.mp4" -size +17M)
	else
		REC_VIDS=$1	
	fi
}

convert() {
	for v in ${REC_VIDS}; do
	    echo "[INFO] Converting ${v}"
		temp=${v/mp4/mp2t}
        mv ${v} ${temp}
		# Check if we converted already - idempotent
		if [[ ! "$(file --mime-type | awk '{print $2}' | cut -d'/' -f2)" == "mp4" ]]; then
			echo "[INFO] Mime check done. Will convert."
	    	ffmpeg -loglevel quiet -i ${temp} -c copy ${v}
        	if [ $? -eq 0 ]; then
        	    echo "[INFO] conversion done, deleting ${temp}"
        	    rm ${temp}
        	fi
		fi
	done
}

main() {
	list_videos
	convert
}

main