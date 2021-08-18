#!/bin/sh

set -exo pipefail

# Valgrind sets `-fno-stack-protector`.
export CFLAGS="$(echo "${CFLAGS}" | sed 's/-fstack-protector-strong//g')"
export CXXFLAGS="$(echo "${CXXFLAGS}" | sed 's/-fstack-protector-strong//g')"

./autogen.sh
./configure --prefix=${PREFIX} --disable-dependency-tracking --enable-only64bit --without-mpicc

make
#make check
make install
