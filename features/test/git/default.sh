#!/bin/bash

set -eux

source dev-container-features-test-lib

EXPECTED=$(cat /usr/local/share/devcontainer-features/git-version)

check "git" which git >/dev/null
check "version" bash -c "git --version | grep -Fq '${EXPECTED}'"
check "clean" test ! -e /tmp/package* -a ! -d /tmp/git.*

reportResults
