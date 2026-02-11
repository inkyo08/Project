#!/bin/bash
set -e

echo "--- Build started ---"

rm -rf Game

find Sources/Runtime \( -name "*.hylo" \) -print0 | xargs -0 hc \
  -L ./Libraries \
  -l SDL3 \
  --experimental-parallel-typechecking \
  -O \
  -o Game

install_name_tool -add_rpath @executable_path/Libraries Game

echo "--- Build succeeded ---"
