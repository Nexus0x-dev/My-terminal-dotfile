#!/usr/bin/env bash

DOTFILES_DIR="$HOME/My-terminal-dotfile"

echo "Starting terminal environment setup..."

rm -f ~/.zshrc
rm -rf ~/.config/kitty
rm -rf ~/.config/fastfetch

mkdir -p ~/.config/kitty
mkdir -p ~/.config/fastfetch

echo "Creating symlinks..."
ln -sf "$DOTFILES_DIR/terminal/kitty.conf" ~/.config/kitty/kitty.conf
ln -sf "$DOTFILES_DIR/terminal/current-theme.conf" ~/.config/kitty/current-theme.conf
ln -sf "$DOTFILES_DIR/terminal/fastfetch.jsonc" ~/.config/fastfetch/config.jsonc
ln -sf "$DOTFILES_DIR/terminal/zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/terminal/p10k.zsh" ~/.p10k.zsh

ZSH_PATH=$(which zsh)
if [ "$SHELL" != "$ZSH_PATH" ] && [ -n "$ZSH_PATH" ]; then
    echo "Changing default shell to Zsh..."
    chsh -s "$ZSH_PATH"
fi

echo "==============================================="
echo "   SETUP COMPLETE! Welcome to Nexus terminal   "
echo "==============================================="

echo "==> Type 'zsh' to apply."
