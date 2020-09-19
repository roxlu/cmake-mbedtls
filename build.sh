#!/bin/bash

# ----------------------------------------------------

build_dir=${PWD}/build
install_dir=${PWD}/installed

# ----------------------------------------------------

if [ ! -d ${build_dir} ] ; then
    mkdir ${build_dir}
fi

# ----------------------------------------------------

# Make sure CMake uses clang as the compiler.
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
export CXXFLAGS="--stdlib=libc++"

# ----------------------------------------------------

cd ${build_dir}
cmake -DCMAKE_INSTALL_PREFIX=${install_dir} \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_C_COMPILER=${CC} \
      -DCMAKE_CXX_COMPILER=${CXX} \
      -DCMAKE_CXX_FLAGS=${CXXFLAGS} \
      -DCMAKE_VERBOSE_MAKEFILE=On \
      -G "Ninja" \
      ..

if [ $? -ne 0 ] ; then
    echo "Failed to configure"
    exit
fi

# ----------------------------------------------------

cd ${build_dir}
cmake --build . \
      --target install \
      --config Release \
      --parallel 24
      
if [ $? -ne 0 ] ; then
    echo "Failed to build"
    exit
fi


# ----------------------------------------------------
