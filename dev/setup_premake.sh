#!/bin/bash

unameOut="$(uname -s)"
case "${unameOut}" in
Linux*) MACHINE=linux ;;
Darwin*) MACHINE=mac ;;
CYGWIN*) MACHINE=cygwin ;;
MINGW*) MACHINE=mingw ;;
*) MACHINE="UNKNOWN:${unameOut}" ;;
esac

# check if use has already installed premake5
if ! command -v premake5 &>/dev/null; then
    # no premake found in path
    if [[ ! -f "bin/premake5" ]]; then
        mkdir -p bin
        pushd bin
        echo Downloading Premake5
        if [ "$MACHINE" = 'mac' ]; then
            PREMAKE_URL=https://github.com/premake/premake-core/releases/download/v5.0.0-beta2/premake-5.0.0-beta2-macosx.tar.gz
            curl $PREMAKE_URL -L -o premake.tar.gz
            echo '620778e24847d4f8e2380cd98922977afec77cc8e805a77edcae1c05e0f6d44a  premake.tar.gz' | sha256sum --check --status || exit 1
        else
            PREMAKE_URL=https://github.com/premake/premake-core/releases/download/v5.0.0-beta2/premake-5.0.0-beta2-linux.tar.gz
            curl $PREMAKE_URL -L -o premake.tar.gz
            echo '4186b8fd66b55df935280f55663c6e46fd568799d89b7ff6a3cfb20d58ff6224  premake.tar.gz' | sha256sum --check --status || exit 1
        fi
        # Export premake5 into bin
        tar -xvf premake.tar.gz 2>/dev/null
        # Delete downloaded archive
        rm premake.tar.gz
        popd
    fi
    export PREMAKE=$PWD/bin/premake5
else
    export PREMAKE=premake5
fi
