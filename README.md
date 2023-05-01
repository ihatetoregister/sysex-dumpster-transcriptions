# sysex-dumpster-transcriptions
Transcriptions of [Sysex Dumpster](https://www.sysexdumpster.com/) podcast generated with [whisper.cpp](https://github.com/ggerganov/whisper.cpp)

# Steps to reproduce
* Fetch and build whisper.cpp
* Run generate.sh

# Tips
Use `grep` to search for topics

    $ grep -i mutable transcriptions/*

Most common words can be generated with [frequent.sh](frequent.sh). This has also been prepared in [stats.txt](stats.txt). 

    $ ./frequent.sh 10 transcriptions/*
