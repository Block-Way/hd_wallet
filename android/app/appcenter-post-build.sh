#!/usr/bin/env bash

cd ..
cd ..

echo "[Post-Build] Load env variables"

echo "[###] Notify email"

./tool/appcenter_build_notify.sh
