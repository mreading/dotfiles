#!/bin/bash

# Setup your entire system with just one command

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

${BASEDIR}/mac/install.sh
${BASEDIR}/link.sh

unset BASEDIR

echo "Full setup complete!"