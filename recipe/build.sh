#!/bin/sh

set -e -o pipefail

# Valgrind sets `-fno-stack-protector`.
export CFLAGS="$(echo "${CFLAGS}" | sed 's/-fstack-protector-strong//g')"
export CXXFLAGS="$(echo "${CXXFLAGS}" | sed 's/-fstack-protector-strong//g')"

./configure --prefix=${PREFIX} --disable-dependency-tracking --enable-only64bit

make
make install
