#!/usr/bin/env bash

RECS_FOLDER=$1

list_videos() {
	REC_VIDS=$(find ${RECS_FOLDER} -type f -name "*.mp4" -size +17M)
}

check_if_already_collaged() {
	for v in ${REC_VIDS}; do
		REC_COLLAGE=${v/mp4/jpeg}
		if [ ! -f "${REC_COLLAGE}" ]; then
			echo "Taking collage of ${v}"
			recordstamps.sh ${v}
		fi
	done
}

main() {
	list_videos
	check_if_already_collaged
}

main

