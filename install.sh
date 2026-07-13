#!/usr/bin/env bash
set -e

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This install script is currently tailored for macOS (Apple Silicon)."
  exit 1
fi

# Install Homebrew
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Append brew shellenv to fish config
FISH_CONFIG="$HOME/.config/fish/config.fish"
mkdir -p "$(dirname "$FISH_CONFIG")"
BREW_SHELLENV="/opt/homebrew/bin/brew shellenv | source"
if ! grep -qxF "$BREW_SHELLENV" "$FISH_CONFIG" 2>/dev/null; then
  echo "$BREW_SHELLENV" >>"$FISH_CONFIG"
fi

# Install fish via Homebrew
if ! command -v fish >/dev/null 2>&1; then
  brew install fish
fi

# Add fish to available shells
FISH_PATH="$(command -v fish)"
if ! grep -qxF "$FISH_PATH" /etc/shells; then
  sudo sh -c "echo $FISH_PATH >> /etc/shells"
fi

# Install packages
BREW_PACKAGES=(tmux mise nvim lazygit lazydocker starship zoxide jq gum libyaml stow)
for pkg in "${BREW_PACKAGES[@]}"; do
  brew install "$pkg"
done
