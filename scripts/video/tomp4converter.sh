#!/usr/bin/env bash

list_videos() {
  if [ -d $1 ]; then
    REC_VIDS=$(find ${RECS_FOLDER} -type f -name "*.mp4" -size +17M)
  else
    REC_VIDS=$1 
  fi
}

to_log() {
  echo "$(date +%Y%m%d%H%M%S.%N) - $1"
}

convert() {
  for v in ${REC_VIDS}; do
    to_log "[INFO] Running pre-flight checks for ${v}"
    temp=${v/mp4/mp2t}
    # Check if file is open (writing
    if is_file_busy ${v} ; then
      continue
    fi
    # Check if we converted already - idempotent
    if is_mime_mp4 ${v}; then
      continue
    fi
  
    # If not skipped until now, conversion should take place
    mv ${v} ${temp}
    ffmpeg -loglevel quiet -i ${temp} -c copy ${v}
    if [ $? -eq 0 ]; then
      to_log "[INFO] File converted with success, deleting ${temp}"
      rm ${temp}
    fi

  done
}

# _Required checks_ to avoid corruption or re-doing the same conversion over and over
# Check if mime is .mp4
is_mime_mp4() {
  to_log "[INFO] Checking file mime type"
  if [[ ! "$(file --mime-type ${v} | awk '{print $2}' | cut -d'/' -f2)" == "mp4" ]]; then
    to_log "[INFO] Mime check done. Not .mp4. Will convert"
    return 1
  fi
  to_log "[INFO] Mime check done. All good, nothing to do"
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
  convert
}

main
