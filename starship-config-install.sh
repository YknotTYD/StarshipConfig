#!/usr/bin/env sh
#starship-config-install.sh

if [ -z "$HOME" ]; then
	echo "\$HOME is unset." 1>&2
	exit 1
fi

set -eu

CONF="$HOME/.config/starship.toml"
CONF_BACKUP="$HOME/.config/.starship.toml.backup"

if [ -f "$CONF" ]; then
    cp "$CONF" "$CONF_BACKUP"
fi

python3 ./starship_toml_gen.py > "$CONF"

