#!/bin/bash

set -x
#set -e
set -o pipefail

whisperPath=./whisper.cpp

# Get urls for all episodes
episodeUrls=$(curl -s -f -L 'https://www.sysexdumpster.com' | grep -Eo 'https?://\S+?.mp3')
#episodeUrls="https://www.sysexdumpster.com/audio/Sysex-Dumpster-2023-03-03-Episode-41.mp3"

transFolder="transcriptions"

for episodeUrl in $episodeUrls
do
    fileNameMp3="${episodeUrl##*/}"
    fileName="${fileNameMp3%.*}"
    
    fileNameWav="$fileName.wav"
    fileNameVtt="$fileName.vtt"
    fileNameWavVtt="$fileNameWav.vtt"
    
    # Check if already transcribed
    if [ -e "$transFolder/$fileNameVtt" ]; then
        echo "Episode already transcribed, skipping"
        continue
    fi
    
    # Fetch episode with curl -> convert to 16kHz wav with ffmpg -> transcribe with whisper (not working)
    #curl -s "$ep" | ffmpeg -f mp3 -i - -ar 16000 -ac 1 -c:a pcm_s16le - | ./whisper.cpp/main -m ./whisper.cpp/models/ggml-base.en.bin -ovtt -

    # Fetch episode
    wget $episodeUrl
    
    # Convert to wav
    ffmpeg -f mp3 -i $fileNameMp3 -ar 16000 -ac 1 -c:a pcm_s16le $fileNameWav

    # Transcribe
    $whisperPath/main -m $whisperPath/models/ggml-base.en.bin -ovtt -f $fileNameWav
    mv $fileNameWavVtt $transFolder/$fileNameVtt

    # Cleanup
    rm $fileNameMp3
    rm $fileNameWav

    sleep 1
done
