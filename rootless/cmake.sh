#!/bin/bash
# Meant for users without root access

set -e

TEMP=`mktemp -d /tmp/cmake.XXXXXXXX`
cd $TEMP

SOURCE=`curl http://www.cmake.org/cmake/resources/software.html|grep 'Latest Release'| grep -E '[1-9][0-9.]+'`
REGEX='Latest Release[^0-9.]*([1-9][0-9.]+)'
[[ $SOURCE =~ $REGEX ]]
FULL_VERSION=${BASH_REMATCH[1]}
VERSION=`echo $FULL_VERSION | cut -d'.' -f1-2`
curl "http://www.cmake.org/files/v${VERSION}/cmake-${FULL_VERSION}.tar.gz" >cmake.tar.gz
tar xf cmake.tar.gz
mv cmake-* cmake
cd cmake
./configure && make
