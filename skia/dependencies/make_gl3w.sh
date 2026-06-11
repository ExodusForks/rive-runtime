#!/bin/sh

set -e

# GL3W requires CMake

GL3W_REPO=https://github.com/skaslev/gl3w
GL3W_STABLE_BRANCH=master

if [ ! -d gl3w ]; then
	echo "Cloning gl3w."
    git clone $GL3W_REPO
fi

cd gl3w && git checkout $GL3W_STABLE_BRANCH && git fetch && git pull
git checkout 97a85e153d7f43c8d2de8b776a33721e238ddb96 || exit 1

mkdir -p build
cd build
cmake ../
make
