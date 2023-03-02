#!/usr/bin/bash

# https://forum.zorin.com/t/changing-plymouth-splash-screen/20709
CWD=$(pwd)
DIR_TEMP=$HOME/.cache/zorin-touchup
DIR_REAL=$HOME/.local/share/zorin-touchup

# REVERT BOOT SPLASH
# sudo apt install plymouth-theme-zorin-logo_2.2

mkdir -p $CWD/deps
cd $CWD/deps
wget -nc https://launchpad.net/~zorinos/+archive/ubuntu/stable/+files/plymouth-theme-zorin-logo_2.2_all.deb
sudo dpkg -i $CWD/deps/plymouth-theme-zorin-logo_2.2_all.deb
sudo update-alternatives --config default.plymouth
sudo apt-mark hold plymouth-theme-zorin-logo
