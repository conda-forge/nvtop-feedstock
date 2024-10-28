#!/bin/bash

set -ex

mkdir build
cd build

if [[ ${target_platform} == linux-* ]]; then
    EXTRA_CMAKE_ARGS="-DNVIDIA_SUPPORT=ON -DAMDGPU_SUPPORT=ON"
fi

if [[ ${target_platform} == osx-* ]]; then
    # See https://github.com/libusb/hidapi/issues/377 for context
    sed -i.bak 's/kIOMainPortDefault/0/' ../src/extract_gpuinfo_apple.m
fi

cmake ${CMAKE_ARGS} \
    ${EXTRA_CMAKE_ARGS} \
    ..

make -j${CPU_COUNT}
make install
