#!/usr/bin/env sh
#curl.sh

# installs starship if necessary
# creates a temporary directory to work in
# clones the repo
# launches starship-tyd-install.sh

if [ -z "$HOME" ]; then
    echo "\$HOME is unset." 1>&2
    exit 1
fi

set -eu

BASHRC="$HOME/.bashrc"
touch "$BASHRC"

if ! command -v starship > /dev/null 2>&1; then # starship: command not found

    mkdir -p "$HOME/.local/bin"                 # add ~/.local/bin to PATH
    SETPATH='PATH="$HOME/.local/bin:$PATH"'     #
                                                #
    if ! grep -q "$SETPATH" "$BASHRC"; then     #
        printf '\n%s\n' "$SETPATH" >> "$BASHRC" #
    fi                                          #

    # install starship
    if ! curl -sSLf https://starship.rs/install.sh | sh -s -- --version v1.24.1 --bin-dir "$HOME/.local/bin"; then
        echo 'Failed to install starship.' 1>&2
        exit 1
    fi
fi

STARSHIP_INIT='eval "$(starship init bash)"'              # add starship to ~/.bashrc
                                                          #
if ! grep -q "$STARSHIP_INIT" "$BASHRC" 2>/dev/null; then #
    printf '\n%s\n' "$STARSHIP_INIT" >> "$BASHRC"         #
fi

TEMP_DIR=$(mktemp -d)          # create a temporary
trap 'rm -rf "$TEMP_DIR"' EXIT # directory to work in
cd "$TEMP_DIR"                 #

git clone https://github.com/YknotTYD/StarshipTYD.git # install the config
cd StarshipTYD                                        #
                                                      #
sh "./src/starship-tyd-install.sh"                    #
