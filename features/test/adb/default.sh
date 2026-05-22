#!/bin/bash

set -eux

source dev-container-features-test-lib

APPS=(
  adb
  sdkmanager
)

for APP in "${APPS[@]}"; do
  check "$APP" which "$APP" >/dev/null
done

check "version-file" test -s /usr/local/share/devcontainer-features/adb-version
check "android-home" bash -c 'test "$ANDROID_HOME" = "/opt/android-sdk"'
check "android-sdk-root" bash -c 'test "$ANDROID_SDK_ROOT" = "/opt/android-sdk"'
check "api-35" test -d /opt/android-sdk/platforms/android-35
check "build-tools-35" test -d /opt/android-sdk/build-tools/35.0.0
check "clean" test ! -e /tmp/cmdline.zip

reportResults
