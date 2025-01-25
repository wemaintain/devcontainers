#!/bin/bash

set -eux

# region Options

USER_NAME=${USER_NAME:-undefined}
USER_ID=${USER_ID:-undefined}
GROUP_ID=${GROUP_ID:-undefined}

# endregion

# region Prerequisites

if [ "$UID" -ne 0 ]; then
  echo -e "(!) User must be root: $UID"
  exit 1
fi

ARCH="$(dpkg --print-architecture)"
if [ "$ARCH" != 'amd64' ] && [ "$ARCH" != 'arm64' ]; then
  echo "(!) Unsupported architecture: $ARCH"
  exit 1
fi

# endregion

# region Installations

groupadd \
  --gid "$GROUP_ID" \
  "$USER_NAME"
useradd \
  --uid "$USER_ID" \
  --gid "$GROUP_ID" \
  --create-home "$USER_NAME" \
  --shell /bin/bash

echo "$USER_NAME" ALL=\(root\) NOPASSWD:ALL >"/etc/sudoers.d/$USER_NAME"
chmod 0440 "/etc/sudoers.d/$USER_NAME"

# endregion
