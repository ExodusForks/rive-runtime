#!/bin/sh
set -e
if [[ -z "${DEPENDENCIES}" ]]; then
    echo "DEPENDENCIES env variable must be set. This script is usually called by other scripts."
    exit 1
fi

mkdir -p $DEPENDENCIES/bin
echo Downloading Premake5
curl https://github.com/premake/premake-core/releases/download/v5.0.0-beta2/premake-5.0.0-beta2-macosx.tar.gz -L -o $DEPENDENCIES//bin/premake_macosx.tar.gz
echo '620778e24847d4f8e2380cd98922977afec77cc8e805a77edcae1c05e0f6d44a  premake-5.0.0-beta2-macosx.tar.gz' | sha256sum --check --status || echo 1
cd $DEPENDENCIES/bin
# Export premake5 into bin
tar -xvf premake_macosx.tar.gz 2>/dev/null
# Delete downloaded archive
rm premake_macosx.tar.gz
