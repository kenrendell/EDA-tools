#!/bin/sh
# Installation script
# Usage: install.sh

[ "$#" -gt 0 ] && { printf 'Usage: install.sh\n'; exit 1; }

cd "${0%/*}" && nix profile install path:"${PWD}"
