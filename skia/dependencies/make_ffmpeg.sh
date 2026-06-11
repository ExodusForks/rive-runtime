#!/bin/sh

set -e

# Based on http://www.alamtechstuffs.com/ffmpegcompile_with_x264/

FFMPEG_REPO=https://github.com/FFmpeg/FFmpeg

# -----------------------------
# Get & Build Skia
# -----------------------------
if [ ! -d FFmpeg ]; then
	echo "Cloning FFmpeg."
    git clone $FFMPEG_REPO
else
    echo "Already have FFmpeg, update it."
    cd FFmpeg && git checkout master && git fetch && git pull
    cd ..
fi

cd FFmpeg

git checkout n4.3.1
git checkout 6b6b9e593dd4d3aaf75f48d40a13ef03bdef9fdb || exit 1

./configure  --disable-debug --enable-gpl --enable-libx264 --enable-pthreads --enable-static --extra-cflags=-I../x264/include --extra-ldflags=-L../x264/lib --extra-libs=-ldl
make -j8
cd ..
