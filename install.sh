#!/usr/bin/env bash

DOTFILES_DIR="$HOME/dotfiles"

echo "🚀 Starting terminal environment setup..."

install_pkg() {
    pkg=$1
    if command -v "$pkg" &> /dev/null; then
        echo "✅ [Already Installed] $pkg"
    else
        echo "📦 [Installing] $pkg..."
        if command -v dnf &> /dev/null; then
            sudo dnf install -y "$pkg"
        elif command -v apt &> /dev/null; then
            sudo apt update && sudo apt install -y "$pkg"
        elif command -v pacman &> /dev/null; then
            sudo pacman -Sy --noconfirm "$pkg"
        else
            echo "⚠️  Unsupported distribution for auto-install. Please install $pkg manually!"
        fi
    fi
}

install_pkg git
install_pkg zsh
install_pkg kitty
install_pkg fastfetch

mkdir -p ~/.config/kitty
mkdir -p ~/.config/fastfetch

echo "🔗 Creating symlinks..."
ln -sf "$DOTFILES_DIR/terminal/kitty.conf" ~/.config/kitty/kitty.conf
ln -sf "$DOTFILES_DIR/terminal/current-theme.conf" ~/.config/kitty/current-theme.conf
ln -sf "$DOTFILES_DIR/terminal/fastfetch.jsonc" ~/.config/fastfetch/config.jsonc
ln -sf "$DOTFILES_DIR/terminal/zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/terminal/p10k.zsh" ~/.p10k.zsh

ZSH_PATH=$(which zsh)
if [ "$SHELL" != "$ZSH_PATH" ] && [ -n "$ZSH_PATH" ]; then
    echo "🔄 Changing default shell to Zsh..."
    chsh -s "$ZSH_PATH"
fi

echo "--------------------------------------------------"
echo "✨ Installation completed! Restart your terminal or open Kitty to enjoy."
