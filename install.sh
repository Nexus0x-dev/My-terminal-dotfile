#!/bin/bash

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "==> Detecting package manager..."

if command -v apt &> /dev/null; then
    echo "[*] Debian/Ubuntu/Kali detected."
    sudo apt update -y
    sudo apt install -y git zsh kitty fastfetch curl
elif command -v dnf &> /dev/null; then
    echo "[*] Fedora detected."
    sudo dnf install -y git zsh kitty fastfetch curl
elif command -v pacman &> /dev/null; then
    echo "[*] Arch Linux detected."
    sudo pacman -Syu --noconfirm git zsh kitty fastfetch curl
else
   echo "[!] Unsupported package manager. Please install git, zsh, kitty, fastfetch manually."
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "==> Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "$P10K_DIR" ]; then
    echo "==> Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
fi

echo "==> Creating symlinks..."
mkdir -p ~/.config/kitty ~/.config/fastfetch

rm -f ~/.zshrc
rm -rf ~/.config/kitty
rm -rf ~/.config/fastfetch

ln -sf "$DOTFILES_DIR/terminal/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/terminal/kitty" "$HOME/.config/kitty"
ln -sf "$DOTFILES_DIR/terminal/fastfetch" "$HOME/.config/fastfetch"

if [ "$SHELL" != "$(which zsh)" ]; then
    echo "==> Changing default shell to Zsh..."
    chsh -s $(which zsh)
fi

echo "=========================================="
echo "   SETUP COMPLETE! Type 'zsh' to start.   "
echo "=========================================="
