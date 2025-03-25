#!/bin/bash

set -eux

# shellcheck source=../../lib/install.sh
source dev-container-features-install-lib

PACKAGE=/tmp/package-kubectl
dc_download kube $PACKAGE

INSTALL_DIR=$(dc_mkdir /opt/bin)

# kubectl
BIN_PATH="$INSTALL_DIR"/kubectl
mv $PACKAGE "$BIN_PATH"
chmod +x "$BIN_PATH"

# kubectx
PACKAGE=/tmp/package.tar.gz
dc_download kubectx $PACKAGE
tar --extract --file $PACKAGE --directory "$INSTALL_DIR"

# kubens
PACKAGE=/tmp/package.tar.gz
dc_download kubens $PACKAGE
tar --extract --file $PACKAGE --directory "$INSTALL_DIR"

#shellcheck disable=SC2119
TARGET=$(dc_mkdir /etc/bash_completion.d)
"${INSTALL_DIR}"/kubectl completion bash >"${TARGET}"/kubectl

rm -f /tmp/package*
