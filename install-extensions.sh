#!/usr/bin/bash

# Frozen versions of favorite extensions
CWD=$(pwd)
DIR_TEMP=$CWD/extensions
DIR_EXTT=$HOME/.local/share/gnome-shell/extensions

mkdir -p $DIR_EXTT
cp -rf $DIR_TEMP/expandable-notifications/expandable-notifications@kaan.g.inam.org $DIR_EXTT
cp -rf $DIR_TEMP/weather-oclock/weatheroclock@CleoMenezesJr.github.io $DIR_EXTT

gnome-extensions list --user

gnome-extensions enable expandable-notifications@kaan.g.inam.org
gnome-extensions enable weatheroclock@CleoMenezesJr.github.io
