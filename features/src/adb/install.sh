#!/bin/bash

set -eux

# shellcheck source=../../lib/install.sh
source dev-container-features-install-lib

dc_install \
  openjdk-17-jre-headless \
  wget \
  unzip

ANDROID_HOME=/opt/android-sdk
CMDLINE_TOOLS_VERSION=14742923
CMDLINE_TOOLS_SHA256=04453066b540409d975c676d781da1477479dde3761310f1a7eb92a1dfb15af7
CMDLINE_TOOLS_ZIP=/tmp/cmdline.zip

mkdir -p "$ANDROID_HOME/cmdline-tools"
wget -q --show-progress \
  "https://dl.google.com/android/repository/commandlinetools-linux-${CMDLINE_TOOLS_VERSION}_latest.zip" \
  -O "$CMDLINE_TOOLS_ZIP"
echo "$CMDLINE_TOOLS_SHA256 $CMDLINE_TOOLS_ZIP" | sha256sum -c

unzip -q "$CMDLINE_TOOLS_ZIP" -d "$ANDROID_HOME/cmdline-tools"
rm -rf "$ANDROID_HOME/cmdline-tools/latest"
mv "$ANDROID_HOME/cmdline-tools/cmdline-tools" "$ANDROID_HOME/cmdline-tools/latest"

yes | "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" --sdk_root="$ANDROID_HOME" --licenses >/dev/null
"$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" --sdk_root="$ANDROID_HOME" \
  "platform-tools" \
  "build-tools;35.0.0" \
  "platforms;android-35"

INSTALL_DIR=$(dc_mkdir /opt/bin)
ln -sf "$ANDROID_HOME/platform-tools/adb" "$INSTALL_DIR/adb"
ln -sf "$ANDROID_HOME/platform-tools/fastboot" "$INSTALL_DIR/fastboot"
ln -sf "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" "$INSTALL_DIR/sdkmanager"
ln -sf "$ANDROID_HOME/cmdline-tools/latest/bin/avdmanager" "$INSTALL_DIR/avdmanager"

dc_bash_config adb <<'EOF'
export ANDROID_HOME=/opt/android-sdk
export ANDROID_SDK_ROOT=/opt/android-sdk
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools"
EOF

mkdir -p /usr/local/share/devcontainer-features
echo "$CMDLINE_TOOLS_VERSION" >/usr/local/share/devcontainer-features/adb-version

rm -f "$CMDLINE_TOOLS_ZIP"
