#!/usr/bin/env bash
set -e

check_packages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
            apt-get update
        fi
        apt-get -y install --no-install-recommends "$@"
    fi
}

# Install dependencies if missing
check_packages wget ca-certificates

# Download cert
mkdir -p /usr/local/share/aws
echo "Downloading AWS RDS CA certificate..."
wget -q https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem -O /usr/local/share/aws/rds-ca-cert.pem
chmod 644 /usr/local/share/aws/rds-ca-cert.pem

# Add alias to /etc/skel so new users get it
echo "Adding alias to /etc/skel/.bash_aliases"
mkdir -p /etc/skel
cat .bash_aliases >> /etc/skel/.bash_aliases

# If the user 'developer' already exists (e.g. from base image), update it.
# Otherwise, relying on /etc/skel is sufficient for when the user is created later.
if id -u developer >/dev/null 2>&1; then
    echo "User 'developer' exists, updating their .bash_aliases"
    USER_HOME=$(getent passwd developer | cut -d: -f6)
    mkdir -p "$USER_HOME"
    cat .bash_aliases >> "$USER_HOME/.bash_aliases"
    chown developer:developer "$USER_HOME/.bash_aliases"
fi
