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
		# Check if we converted already - idempotent
		if is_file_open ${v} ; then
			echo "[INFO] ${v} is busy. Skipping it..."
			continue
		fi
		if [[ ! "$(file --mime-type ${v} | awk '{print $2}' | cut -d'/' -f2)" == "mp4" ]]; then
        		mv ${v} ${temp}
			echo "[INFO] Mime check done. Will convert."
	    	ffmpeg -loglevel quiet -i ${temp} -c copy ${v}
        	if [ $? -eq 0 ]; then
        	    echo "[INFO] conversion done, deleting ${temp}"
        	    rm ${temp}
        	fi
		fi
	done
}

is_file_open() {
	# If the file is open, we do not want to move it around
	REC_FILE=$1
	lsof -f -- $REC_FILE &> /dev/null
	if [[ $? == 0 ]]; then
		return 0
	fi

	return 1
}

main() {
	list_videos
	convert
}

main
