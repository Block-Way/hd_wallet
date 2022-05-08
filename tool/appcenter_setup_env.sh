#!/usr/bin/env bash

echo "[Post-Clone] Load env variables"

pwd

COMMIT_HASH=$(git rev-parse HEAD)

echo "[Post-Clone] Prepare Env"
echo "IS_BETA=$IS_BETA
BUILD_ID=$APPCENTER_BUILD_ID
COMMIT_HASH=$COMMIT_HASH
" >.env
cat .env

echo "" >.env.dev

echo "[Post-Clone] Install Flutter"

git clone -b stable https://github.com/flutter/flutter.git
export PATH=$(pwd)/flutter/bin:$PATH

echo "[###] Disable Flipper"
sed -i '' 's/path: .\/third_party\/flutter_flipperkit/#none/g' pubspec.yaml
sed -i '' 's/flutter_flipperkit/#none/g' pubspec.yaml
cat lib/main_prod.dart >lib/main.dart

echo "[Post-Clone] Run Flutter Doctor"

flutter channel stable
flutter doctor
