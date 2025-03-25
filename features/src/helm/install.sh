#!/bin/bash

set -eux

# shellcheck source=../../lib/install.sh
source dev-container-features-install-lib

PACKAGE=/tmp/package.tar.gz
dc_download helm $PACKAGE

# helm
INSTALL_DIR=$(dc_mkdir /opt/bin)
tar --extract --file $PACKAGE --strip-components 1 --directory "$INSTALL_DIR"

# helm-diff
HELM_PLUGINS=$(dc_mkdir /opt/helm/plugins)
dc_download helm-diff $PACKAGE
tar --extract --file $PACKAGE --directory "$HELM_PLUGINS"

# helmfile
dc_download helmfile $PACKAGE
tar --extract --file $PACKAGE --directory "$INSTALL_DIR"

# shellcheck disable=SC2119
TARGET=$(dc_mkdir /etc/bash_completion.d)
"${INSTALL_DIR}"/helm completion bash >"${TARGET}"/helm

rm -f /tmp/package*
