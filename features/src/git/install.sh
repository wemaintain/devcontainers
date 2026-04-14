#!/bin/bash

set -eux

# shellcheck source=../../lib/install.sh
source dev-container-features-install-lib

dc_install \
  build-essential \
  gettext \
  libcurl4-gnutls-dev \
  libexpat1-dev \
  libssl-dev \
  zlib1g-dev

PACKAGE=/tmp/package.tar.gz
dc_download git $PACKAGE
EXPECTED_VERSION=$(dc_version git)

SRCDIR=$(mktemp -d /tmp/git.XXXXXXXX)
tar --extract --file $PACKAGE --strip-components 1 --directory "$SRCDIR"

make -C "$SRCDIR" prefix=/opt -j"$(nproc)" install

mkdir -p /usr/local/share/devcontainer-features
echo "$EXPECTED_VERSION" >/usr/local/share/devcontainer-features/git-version

rm -rf /tmp/package* "$SRCDIR"
