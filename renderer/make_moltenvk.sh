#!/bin/sh

set -e

mkdir -p dependencies
cd dependencies

if [ ! -d MoltenVK ]; then
    echo "Cloning MoltenVK..."
    git clone https://github.com/rive-app/MoltenVK.git
else
    echo "Already have MoltenVK..."
fi

cd MoltenVK

git checkout edbdcf054b2be9c84430f719ae99e78f9e845350 || exit 1

echo "Fetching dependencies..."
./fetchDependencies --macos

echo "Building branch with experimental support for VK_EXT_rasterization_order_attachment_access..."
git checkout origin/VK_EXT_rasterization_order_attachment_access
git checkout 7de494443641fc4f81d8232fe379c336face30ab || exit 1
xcodebuild -project MoltenVKPackaging.xcodeproj -scheme "MoltenVK Package (macOS only)" -configuration "Release"
