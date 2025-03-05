#!/bin/bash

set -eux

if [ "$UID" -ne 0 ]; then
  echo -e "(!) User must be root: $UID"
  exit 1
fi

ARCH="$(dpkg --print-architecture)"
if [ "$ARCH" != 'amd64' ] && [ "$ARCH" != 'arm64' ]; then
  echo "(!) Unsupported architecture: $ARCH"
  exit 1
fi

#---

apt update --quiet
apt install --yes --no-install-recommends \
  ca-certificates \
  curl \
  unzip
rm -rf /var/lib/apt/lists/*

#---

#? https://developer.hashicorp.com/terraform/install
#? https://releases.hashicorp.com/terraform/{VERSION}/terraform_{VERSION}_SHA256SUMS
PACKAGE_VERSION=1.11.1
case $ARCH in
amd64)
  PACKAGE_URL="https://releases.hashicorp.com/terraform/${PACKAGE_VERSION}/terraform_${PACKAGE_VERSION}_linux_amd64.zip"
  PACKAGE_SUM=1af58f77958186227bce9ae4d9b08e004fb0902c7a6bdc813cdbab88739f9316
  ;;
arm64)
  PACKAGE_URL="https://releases.hashicorp.com/terraform/${PACKAGE_VERSION}/terraform_${PACKAGE_VERSION}_linux_arm64.zip"
  PACKAGE_SUM=35ebb4f6a34cec8a5f7983d6d7e25e115f4b8958ac13bd306fe76dcec80967ec
  ;;
esac

PACKAGE=/tmp/package.zip
curl -fLsS "$PACKAGE_URL" -o $PACKAGE
echo "$PACKAGE_SUM $PACKAGE" | sha256sum -c

INSTALL_DIR=/opt/bin
mkdir -p $INSTALL_DIR
unzip $PACKAGE -d $INSTALL_DIR
rm -f $PACKAGE

#? https://www.npmjs.com/package/cdktf-cli?activeTab=versions
npm install -g cdktf-cli@0.20.11

#---

#? https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#enable-tab-completion
${INSTALL_DIR}/terraform -install-autocomplete
