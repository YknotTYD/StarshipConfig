#!/usr/bin/env sh
#sudo-cache-worker.sh

SUDO_CACHE_FILE="/tmp/sudo_cache_${USER}_$$"
export SUDO_CACHE_FILE

_launch_cache_worker() {
    while true; do
        if sudo -vn 2>/dev/null; then
            echo -ne "\x1b[38;2;255;255;0m#" > "$SUDO_CACHE_FILE"
        else
            echo -ne "\x1b[38;2;0;255;0m$"   > "$SUDO_CACHE_FILE"
        fi
        sleep 1
    done
}

_launch_cache_worker &
SUDO_CACHE_WORKER_PID=$!
trap "kill $SUDO_CACHE_WORKER_PID 2>/dev/null; [ -f \"$SUDO_CACHE_FILE\" ] && rm \"$SUDO_CACHE_FILE\"" EXIT
