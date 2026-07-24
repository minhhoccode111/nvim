#!/bin/bash
set -euo pipefail

echo "Removing nvim data, state, and cache directories..."
rm -rf "$HOME/.local/share/nvim"
rm -rf "$HOME/.local/state/nvim"
rm -rf "$HOME/.cache/nvim"
echo "Done. Config at ~/.config/nvim and nvim binary are preserved."
