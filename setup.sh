#!/bin/sh
PACKAGE_MANAGER=apt
INSTALL_COMMAND="sudo $PACKAGE_MANAGER install -y"

echo "Assuming your Package Manager is $PACKAGE_MANAGER"
echo "Assuming you're a normal user and sudo is installed and configured (THE USER SHOULD BE IN THE SUDO GROUP OR ALTERNATIVELY IN THE WHEEL GROUP!)"

echo "-- UPGRADING THE SYSTEM --"
sudo apt update && sudo apt upgrade

echo "-- DOTFILES --"
echo "Just to be sure, we'll try to install git. It is probably already installed for cloning this repository."
$INSTALL_COMMAND git
$INSTALL_COMMAND stow
git clone --depth=1 https://github.com/techrisdev/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./Create_Symlinks_Linux.sh
cd ~

echo "-- INSTALLING PACKAGES --"
# neovim as a editor
$INSTALL_COMMAND neovim
# Xorg as Display Server
$INSTALL_COMMAND xorg
# zsh as a shell
$INSTALL_COMMAND zsh
$INSTALL_COMMAND zsh-autosuggestions
$INSTALL_COMMAND zsh-syntax-highlighting
# Starship as a shell prompt
$INSTALL_COMMAND starship

$INSTALL_COMMAND exa

# TODO: Window Manager, Polybar etc.

echo "-- ZSH --"
# Set the default shell to zsh
echo "Changing the default shell. Your password will be required."
chsh -s /usr/bin/zsh
