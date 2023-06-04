#!/bin/bash

if [ $# -eq 0 ]; then
    echo "No file specified. Usage: ./converter [--mp4tomov/--movtomp4] [path to file]"
    exit 1
fi

flag="$1"
file="$2"

if [ "$flag" == "--mp4tomov" ]; then
    if [[ $file == *.mp4 ]]; then
        filename="${file%.*}"
        output_filename="${filename}.mov"
        ffmpeg -i "$file" -c:v prores -profile:v 3 -c:a pcm_s16le "$output_filename"
        echo "Conversion complete: $output_filename"
    else
        echo "Invalid file format. Only MP4 files are supported."
    fi
elif [ "$flag" == "--movtomp4" ]; then
    if [[ $file == *.mov ]]; then
        filename="${file%.*}"
        output_filename="${filename}.mp4"
        ffmpeg -i "$file" -c:v libx264 -preset medium -crf 23 -c:a aac -b:a 128k "$output_filename"
        echo "Conversion complete: $output_filename"
    else
        echo "Invalid file format. Only MOV files are supported."
    fi
else
    echo "Invalid flag. Usage: ./converter [--mp4tomov/--movtomp4] [path to file]"
fi
