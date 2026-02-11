#!/bin/sh

if test "$CONDA_BUILD_CROSS_COMPILATION" = "1"
then
  CMAKE_ARGS="${CMAKE_ARGS} -DQT_HOST_PATH=${BUILD_PREFIX} -DQT_FORCE_BUILD_TOOLS=ON"
fi

export CXXFLAGS="${CXXFLAGS} -I${PREFIX}/include/qt6/QtWaylandGlobal/${PKG_VERSION}"

cmake -LAH --log-level STATUS -G "Ninja" -B build ${CMAKE_ARGS} \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_RPATH:STRING="${PREFIX}/lib" \
  -DCMAKE_UNITY_BUILD=ON \
  -DCMAKE_UNITY_BUILD_BATCH_SIZE=32 \
   .

cmake --build build --target install
