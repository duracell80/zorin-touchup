#!/usr/bin/bash

# Frozen versions of favorite extensions
CWD=$(pwd)
DIR_TEMP=$CWD/extensions
DIR_EXTT=$HOME/.local/share/gnome-shell/extensions

sudo apt install chrome-gnome-shell gnome-shell-extension-prefs gnome-weather intltool

mkdir -p $DIR_EXTT
cp -rf $DIR_TEMP/expandable-notifications/expandable-notifications@kaan.g.inam.org $DIR_EXTT
cp -rf $DIR_TEMP/clocks/weatheroclock@CleoMenezesJr.github.io $DIR_EXTT
cp -rf $DIR_TEMP/clocks/unix-timestamp-clock@se1exin.github.com $DIR_EXTT
#cp -rf $DIR_TEMP/bing-wallpaper/BingWallpaperineffable-gmail.com.v40.shell-extension $DIR_EXTT

cd $DIR_TEMP/bing-wallpaper
$DIR_TEMP/bing-wallpaper/install.sh

cd $CWD

gnome-shell --version
gnome-extensions list --user
