#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Installing homebrew and mac defaults..."
${DIR}/brew.sh
${DIR}/macos.sh

open -a flux
