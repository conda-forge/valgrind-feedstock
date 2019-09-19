#!/bin/sh

set -exo pipefail

# Valgrind sets `-fno-stack-protector`.
export CFLAGS="$(echo "${CFLAGS}" | sed 's/-fstack-protector-strong//g')"
export CXXFLAGS="$(echo "${CXXFLAGS}" | sed 's/-fstack-protector-strong//g')"

# Patch Valgrind to use the macOS SDK for mach headers.
if [ "$(uname)" == "Darwin" ]
then
    MACH_INC="/usr/include/mach/"
    sed -i.bak -e \
        "s@${MACH_INC}@${CONDA_BUILD_SYSROOT}${MACH_INC}@g" \
        "${SRC_DIR}/coregrind/Makefile.in"
    export LDFLAGS="${LDFLAGS} -undefined dynamic_lookup"
fi

./autogen.sh

./configure --prefix=${PREFIX} --disable-dependency-tracking --enable-only64bit

make
#make check
make install
