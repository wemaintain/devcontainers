#!/bin/bash

set -eux

# shellcheck source=../../lib/install.sh
source dev-container-features-install-lib

dc_install \
  unzip

PACKAGE=/tmp/package.zip
dc_download terraform $PACKAGE

INSTALL_DIR=$(dc_mkdir /opt/bin)
mkdir -p "$INSTALL_DIR"
unzip $PACKAGE -d "$INSTALL_DIR"

#---

#? https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#enable-tab-completion
"${INSTALL_DIR}"/terraform -install-autocomplete
