#!/usr/bin/env bash
#Place this script in project/ios/

# fail if any command fails
set -e
# debug log
set -x

cd ..

./tool/appcenter_setup_env.sh

export PATH=$(pwd)/flutter/bin:$PATH

echo "[###] Build iOS"

flutter build ios --release --no-codesign -t lib/main_prod.dart
