#!/bin/bash

set -eux

source dev-container-features-test-lib

check "adb-emu-alias" bash -c 'test "$(adb emu avd name)" = "Dummy_Emulator"'

reportResults
