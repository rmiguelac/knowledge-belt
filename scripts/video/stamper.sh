#!/usr/bin/env bash

RECS_FOLDER=$1

list_videos() {
  REC_VIDS=$(find ${RECS_FOLDER} -type f -name "*.mp4" -size +17M)
}

to_log() {
  echo "$(date +%Y%m%d%H%M%S.%N) - $1"
}

collage() {
  for v in ${REC_VIDS}; do
    if is_file_busy ${v}; then
      continue
    fi
    if has_collage ${v}; then
      continue 
    fi
    to_log "[INFO] Starting collage process for ${v}"
    recordstamps.sh ${v}
  done
  to_log "[INFO] Finished collage process"
}

# Required checks to avoid taking collage of ongoing recordings or ones that already have a collage
has_collage() {
    to_log "[INFO] Checking if file already has collage"
  REC_COLLAGE=${v/mp4/jpeg}
  if [ ! -f "${REC_COLLAGE}" ]; then
      to_log "[INFO] Collage does not exist"
    return 1
  fi

    to_log "[INFO] Collage already exists"
  return 0
}

# Check if file is being written to - If the file is open, we do not want to move it around as a recording is ongoing
is_file_busy() {
  to_log "[INFO] Checking if file is busy"
  REC_FILE=$1
  lsof -f -- $REC_FILE &> /dev/null
  if [[ $? == 0 ]]; then
    to_log "[INFO] File is busy"
    return 0
  fi

  to_log "[INFO] File is not busy"
  return 1
}

main() {
  list_videos
  collage
}

main
