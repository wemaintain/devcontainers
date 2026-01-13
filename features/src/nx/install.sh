#!/bin/bash

set -eux

# shellcheck source=../../lib/install.sh
source dev-container-features-install-lib

npm install -g \
  "nx@$(dc_version nx)"
