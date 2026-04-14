#!/bin/bash

set -eux

source dev-container-features-test-lib

EXPECTED=$(jq -r '.customizations.manifest.dependencies[] | select(.name == "git") | .version' "$(dirname "$0")/../../src/git/devcontainer-feature.json")

check "git" which git >/dev/null
check "version" bash -c "git --version | grep -Fq '${EXPECTED}'"
check "clean" test ! -e /tmp/package* -a ! -d /tmp/git.*

reportResults
