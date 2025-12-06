#!/usr/bin/env sh
#curl.sh

if [ -z "$HOME" ]; then
	echo "\$HOME is unset." 1>&2
	exit 1
fi

set -eu

BASHRC="$HOME/.bashrc"
touch "$BASHRC"

if ! command -v starship > /dev/null; then
	curl -sS https://starship.rs/install.sh | sh -s -- --version v1.24.1
fi

if ! grep -q "starship init bash" "$BASHRC"; then
	echo 'eval "$(starship init bash)"' >> "$BASHRC"
fi

TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"
trap 'rm -rf "$TEMP_DIR"' EXIT

git clone https://github.com/YknotTYD/StarshipConfig.git StarshipConfig
cd StarshipConfig
sh starship-config-install.sh
