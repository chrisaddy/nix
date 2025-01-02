#!/usr/bin/env sh

rm -rf $HOME/.config/broot

sudo nix flake update
darwin-rebuild switch --flake ~/.config/nix-darwin

cargo install kanata
/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager activate

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
/opt/homebrew/bin/brew upgrade
/opt/homebrew/bin/brew update
/opt/homebrew/bin/brew install --cask ghostty

exec $SHELL
