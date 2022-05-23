#!/usr/bin/env bash
# place this script in project/android/app/
cd ..
# fail if any command fails
set -e
# debug log
set -x

cd ..

./tool/appcenter_setup_env.sh

export PATH=$(pwd)/flutter/bin:$PATH

echo "[###] Disable Debug Network on Master"

if [ "$APPCENTER_BRANCH" != "master" ]; then
   sed -i '' 's/system" \/>/system" \/>  <certificates src="user" \/>/' android/app/src/main/res/xml/network_security_config.xml
fi

echo "[###] Build Apk"
# if you get "Execution failed for task ':app:lintVitalRelease'." error, uncomment next two lines
# flutter build apk --debug
# flutter build apk --profile
flutter build apk --release -t lib/main_prod.dart

# if you need build bundle (AAB) in addition to your APK, uncomment line below and last line of this script.
#flutter build appbundle --release --build-number $APPCENTER_BUILD_ID

# copy the APK where AppCenter will find it
mkdir -p android/app/build/outputs/apk/
mv build/app/outputs/apk/release/app-release.apk $_

# copy the AAB where AppCenter will find it
#mkdir -p android/app/build/outputs/bundle/; mv build/app/outputs/bundle/release/app-release.aab $_
