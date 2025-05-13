#!/bin/bash

set -eux

# shellcheck source=../../lib/install.sh
source dev-container-features-install-lib

npm install -g \
  "cdktf-cli@$(dc_version ng)"
