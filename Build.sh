#!/bin/bash
set -e

echo "--- Load Library ---"

echo ""

git submodule update --init --recursive

cmake -S External/SDL -B External/SDL/build \
  -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=ON \
  -DSDL_VIDEO=ON \
  -DSDL_GPU=ON \
  -DSDL_RENDER=OFF \
  -DSDL_AUDIO=OFF \
  -DSDL_CAMERA=OFF \
  -DSDL_JOYSTICK=OFF \
  -DSDL_HAPTIC=OFF \
  -DSDL_HIDAPI=OFF \
  -DSDL_POWER=OFF \
  -DSDL_SENSOR=OFF \
  -DSDL_DIALOG=OFF \
  -DSDL_TRAY=OFF \
  -DSDL_ARMNEON=ON \
  -DSDL_CCACHE=ON \
  -DSDL_TEST_LIBRARY=OFF \
  -DSDL_TESTS=OFF \
  -DSDL_EXAMPLES=OFF \

cmake --build External/SDL/build --config Release

mkdir -p Build
cp External/SDL/build/libSDL3*.dylib Build/

echo ""

echo "--- Build started ---"

echo ""

find Sources/Runtime \( -name "*.hylo" \) -print0 | xargs -0 hc \
  -L ./Build \
  -l SDL3 \
  --experimental-parallel-typechecking \
  -O \
  -v \
  -o Build/Game

install_name_tool -add_rpath @executable_path Build/Game

echo ""
echo ""

echo "--- Build succeeded ---"
