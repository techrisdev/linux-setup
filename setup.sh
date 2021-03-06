#!/bin/sh
PACKAGE_MANAGER=apt
INSTALL_COMMAND="sudo $PACKAGE_MANAGER install -y"
clear
echo "Assuming your Package Manager is $PACKAGE_MANAGER"
echo "Assuming you're a normal user and sudo is installed and configured (THE USER SHOULD BE IN THE SUDO GROUP OR ALTERNATIVELY IN THE WHEEL GROUP!)"

echo "-- UPGRADING THE SYSTEM --"
sudo apt update && sudo apt upgrade

clear
echo "-- DOTFILES --"
echo "Just to be sure, we'll try to install git. It is probably already installed for cloning this repository."
$INSTALL_COMMAND git
$INSTALL_COMMAND stow
git clone --depth=1 https://github.com/techrisdev/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./Create_Symlinks_Linux.sh
cd ~

clear
echo "-- INSTALLING PACKAGES --"
# neovim as a editor
$INSTALL_COMMAND neovim
# Xorg as Display Server
$INSTALL_COMMAND xorg

$INSTALL_COMMAND htop

# zsh as a POSIX shell
$INSTALL_COMMAND zsh
$INSTALL_COMMAND zsh-autosuggestions
$INSTALL_COMMAND zsh-syntax-highlighting

# fish as default shell
$INSTALL_COMMAND fish

$INSTALL_COMMAND tmux

# JetBrains Mono Nerd Font
$INSTALL_COMMAND wget
$INSTALL_COMMAND unzip
if [ "$(find . -name "JetBrains Mono Regular Nerd Font Complete.ttf" | wc -l)" = "0" ]; then
echo "-- INSTALLING THE JetBrains Mono FONT --"
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip"
unzip JetBrainsMono.zip -d JetBrainsMono
mkdir -p ~/.local/share/fonts
mv JetBrainsMono/*.ttf ~/.local/share/fonts
fi

# Starship as a shell prompt
$INSTALL_COMMAND curl
clear
echo "-- STARSHIP PROMPT: PLEASE ANSWER 'y' TO THE NEXT PROMPT"
sh -c "$(curl -fsSL https://starship.rs/install.sh)"

$INSTALL_COMMAND exa

# TODO: Window Manager, Polybar etc.

# Alacritty Terminal
clear
echo "-- RUSTUP: PLEASE ANSWER '1' TO THE NEXT PROMPT --"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
$INSTALL_COMMAND cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
cargo install alacritty

clear
echo "-- SHELL --"
# Set the default shell to fish
echo "Changing the default shell. Your password will be required."
chsh -s /usr/bin/fish

echo "-- CLEANING UP --"
rm -rf ~/JetBrainsMono*
