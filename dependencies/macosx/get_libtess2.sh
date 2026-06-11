#!/bin/sh

set -e

if [[ -z "${DEPENDENCIES}" ]]; then
    echo "DEPENDENCIES env variable must be set. This script is usually called by other scripts."
    exit 1
fi

pushd $DEPENDENCIES
LIBTESS2_REPO=https://github.com/memononen/libtess2
LIBTESS2_STABLE_BRANCH=master

if [ ! -d libtess2 ]; then
    echo "Cloning libtess2."
    git clone $LIBTESS2_REPO
fi

pushd libtess2
git checkout $LIBTESS2_STABLE_BRANCH && git fetch && git pull
git checkout 9a450cc9e5b4b79c36b89648f8b92fe65b6dd407 || exit 1
popd

popd
