#!/bin/bash

if [ $# -eq 0 ]; then
    echo "No file specified. Usage: ./converter [path to mp4 file]"
    exit 1
fi

file="$1"
if [[ $file == *.mp4 ]]; then
    filename="${file%.*}"
    output_filename="${filename}_mjpeg.mov"

    ffmpeg -i "$file" -vcodec mjpeg -q:v 2 -acodec pcm_s16be -q:a 0 -f mov "$output_filename"

    echo "Conversion complete: $output_filename"
else
    echo "Invalid file format. Only MP4 files are supported."
fi