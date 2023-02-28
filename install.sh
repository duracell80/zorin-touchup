#!/usr/bin/bash

CWD=$(pwd)
DIR_TEMP=$HOME/.cache/zorin-touchup
DIR_ICON=$HOME/.local/share/zorin-touchup/icons
DIR_REAL_LIGHT=$HOME/.local/share/icons/Light-Icons
DIR_REAL_DARK=$HOME/.local/share/icons/Dark-Icons

mkdir -p $DIR_TEMP/icons/light
mkdir -p $DIR_TEMP/icons/dark
mkdir -p $DIR_ICON/light
mkdir -p $DIR_ICON/dark
mkdir -p $DIR_REAL_LIGHT
mkdir -p $DIR_REAL_DARK

cp -rf $CWD/icons/White-Icons/* $DIR_TEMP/icons/light
cp -rf $CWD/icons/Black-Icons/* $DIR_TEMP/icons/dark

cp -rf $CWD/icons/White-Icons/* $DIR_ICON/light
cp -rf $CWD/icons/Black-Icons/* $DIR_ICON/dark

cp $CWD/remix-icons.sh $HOME/.local/share/zorin-touchup/
chmod u+x $HOME/.local/share/zorin-touchup/*.sh

# SET ANY AUTOSTART SCRIPTS FOR DESKTOP ENVIRONMENT
for filename in $CWD/*.desktop; do
    [ -e "$filename" ] || continue
    file=$(echo $filename | sed -e "s|${CWD}/||g")

    cp -f "$filename" "$file.tmp"
    sed -i "s|Exec=~/|Exec=$HOME/|g" "$file.tmp"
    mv -f "$file.tmp" "$HOME/.config/autostart/$file"
done
