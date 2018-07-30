#!/bin/bash

# Script for building clang locally. Saves to the given destination.

# Exit on first error
set -e

SAVE_DESTINATION=`mktemp -d /tmp/clang.XXXX`

# Set up temp directory
TEMP=`mktemp -d "$SAVE_DESTINATION"/XXXXX`
cd $TEMP

# Grab the current version number
SOURCE=`curl http://llvm.org/releases/download.html | grep 'Download LLVM' | head -1`
REGEX='Download LLVM ([3-9]\.[0-9])'
[[ $SOURCE =~ $REGEX ]]
VERSION=${BASH_REMATCH[1]}

# Get llvm
curl http://llvm.org/releases/"$VERSION"/llvm-"$VERSION".src.tar.gz -o llvm.src.tar.gz
tar xzf llvm.src.tar.gz
mv llmv-* llvm

# Get clang
cd $TEMP/llvm/tools
curl http://llvm.org/releases/"$VERSION"/clang-"$VERSION".src.tar.gz -o clang.src.tar.gz
tar xzf clang.src.tar.gz
mv clang-* clang

# Get clang tools
cd $TEMP/llvm/tools/clang/tools
curl http://llvm.org/releases/"$VERSION"/clang-tools-extra-"$VERSION".src.tar.gz -o extra.src.tar.gz
tar xzf extra.src.tar.gz
mv clang-tools-extra-* extra

# Get compiler-rt
cd $TEMP/llvm/projects
curl http://llvm.org/releases/"$VERSION"/compiler-rt-"$VERSION".src.tar.gz -o compiler-rt.src.tar.gz
tar xzf compiler-rt.src.tar.gz
mv compiler-rt-* compiler-rt

# Build
cd $TEMP
mkdir build
cd build
$TEMP/llvm/configure && make

# Copy to separate location and clean up
mv $TEMP/build/Release+Asserts $SAVE_DESTINATION
rm -rf $TEMP

echo "Clang files successfully built and saved to $SAVE_DESTINATION"
