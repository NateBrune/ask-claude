#!/bin/sh
# Link ask-claude into ~/.local/bin so key bindings and the shell can find it
set -e
here=$(cd "$(dirname "$0")" && pwd)
mkdir -p "$HOME/.local/bin"
ln -sf "$here/ask-claude" "$HOME/.local/bin/ask-claude"
echo "linked $HOME/.local/bin/ask-claude -> $here/ask-claude"
