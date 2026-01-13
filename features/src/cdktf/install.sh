#!/bin/bash

set -eux

# shellcheck source=../../lib/install.sh
source dev-container-features-install-lib

# Install dependencies for building native modules
dc_install python3 make g++

npm install -g \
  "cdktf-cli@$(dc_version ng)"
