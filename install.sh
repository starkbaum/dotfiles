#!/bin/bash
set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()    { echo -e "${GREEN}[INFO]${NC} $1"; }
warning() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error()   { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

# Detect distro
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    error "Cannot detect distro"
fi

info "Detected distro: $DISTRO"

install_arch() {
    info "Installing packages via pacman..."
    sudo pacman -S --needed --noconfirm \
        i3-wm i3status i3lock \
        polybar picom rofi dunst \
        feh maim xclip xorg-xev \
        alacritty \
        stow git \
        ttf-jetbrains-mono \
        ttf-firacode-nerd \
        ttf-nerd-fonts-symbols \
        ttf-nerd-fonts-symbols-mono \
        papirus-icon-theme \
        playerctl \
        dmenu \
        xorg-xrandr arandr

    info "Installing AUR packages..."
    if ! command -v yay &>/dev/null; then
        info "Installing yay..."
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        (cd /tmp/yay && makepkg -si --noconfirm)
        rm -rf /tmp/yay
    fi

    yay -S --needed --noconfirm \
        betterlockscreen \
        logseq-desktop-bin
}

install_debian() {
    info "Updating package lists..."
    sudo apt update

    info "Installing packages via apt..."
    sudo apt install -y \
        i3 i3status i3lock \
        polybar picom rofi dunst \
        feh maim xclip x11-utils \
        alacritty \
        stow git curl wget \
        papirus-icon-theme \
        playerctl \
        dmenu \
        x11-xserver-utils arandr \
        fonts-jetbrains-mono

    # FiraCode Nerd Font
    info "Installing FiraCode Nerd Font..."
    FONT_DIR="$HOME/.local/share/fonts"
    mkdir -p "$FONT_DIR"
    wget -q --show-progress \
        "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip" \
        -O /tmp/FiraCode.zip
    unzip -o /tmp/FiraCode.zip -d "$FONT_DIR/FiraCode" > /dev/null
    rm /tmp/FiraCode.zip

    # Symbols Nerd Font
    info "Installing Symbols Nerd Font..."
    wget -q --show-progress \
        "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.zip" \
        -O /tmp/NerdSymbols.zip
    unzip -o /tmp/NerdSymbols.zip -d "$FONT_DIR/NerdSymbols" > /dev/null
    rm /tmp/NerdSymbols.zip

    fc-cache -fv > /dev/null
    info "Fonts installed and cache updated"

    # betterlockscreen
    info "Installing betterlockscreen..."
    if ! command -v betterlockscreen &>/dev/null; then
        wget -q --show-progress \
            "https://github.com/betterlockscreen/betterlockscreen/releases/latest/download/betterlockscreen" \
            -O /tmp/betterlockscreen
        chmod +x /tmp/betterlockscreen
        sudo mv /tmp/betterlockscreen /usr/local/bin/
    fi
}

case "$DISTRO" in
    arch|cachyos|endeavouros|manjaro)
        install_arch
        ;;
    debian|ubuntu|linuxmint|pop)
        install_debian
        ;;
    *)
        error "Unsupported distro: $DISTRO"
        ;;
esac

# Clone dotfiles if not already present
if [ ! -d "$HOME/dotfiles" ]; then
    info "Cloning dotfiles..."
    git clone https://github.com/starkbaum/dotfiles.git "$HOME/dotfiles"
else
    info "Dotfiles already present, pulling latest..."
    git -C "$HOME/dotfiles" pull
fi

# Create required directories
info "Creating required directories..."
mkdir -p "$HOME/Pictures/wallpaper"
mkdir -p "$HOME/Pictures/rofi"
mkdir -p "$HOME/Pictures/Screenshots"

# Run stow
info "Applying dotfiles with stow..."
cd "$HOME/dotfiles"
stow --target="$HOME" . 2>&1 | grep -v "^$" || true

# Initialize betterlockscreen if wallpaper exists
if ls "$HOME/Pictures/wallpaper/"*.jpg &>/dev/null || ls "$HOME/Pictures/wallpaper/"*.png &>/dev/null; then
    info "Initializing betterlockscreen..."
    betterlockscreen -u "$HOME/Pictures/wallpaper/" 2>/dev/null || true
else
    warning "No wallpapers found in ~/Pictures/wallpaper/ — add some and run: betterlockscreen -u ~/Pictures/wallpaper/"
fi

info "Done! A few manual steps remaining:"
echo "  1. Add wallpapers to ~/Pictures/wallpaper/"
echo "  2. Add rofi image to ~/Pictures/rofi/"
echo "  3. Log out and select i3 from your display manager"
echo "  4. Update polybar hwmon-path for temperature sensor (may differ per machine)"
