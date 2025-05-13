#!/bin/bash

set -eux

source dev-container-features-test-lib

APPS=(
  ng
)

for APP in "${APPS[@]}"; do
  check "$APP" which "$APP" >/dev/null
done

check "clean" test ! -e /tmp/package*

reportResults
