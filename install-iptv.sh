#!/usr/bin/bash

CWD=$(pwd)
DIR_TEMP=$HOME/.cache/zorin-touchup
DIR_REAL=$HOME/.local/share/zorin-touchup/iptv

mkdir -p $DIR_TEMP/iptv
mkdir -p $DIR_REAL

#cp $CWD/remix-icons.sh $HOME/.local/share/zorin-touchup/
#chmod u+x $HOME/.local/share/zorin-touchup/*.sh

# SET ANY AUTOSTART SCRIPTS FOR DESKTOP ENVIRONMENT
for filename in $CWD/*.desktop; do
    [ -e "$filename" ] || continue
    file=$(echo $filename | sed -e "s|${CWD}/||g")

    cp -f "$filename" "$file.tmp"
    sed -i "s|Exec=~/|Exec=$HOME/|g" "$file.tmp"
    mv -f "$file.tmp" "$HOME/.config/autostart/$file"
done

# Install Hypnotix 2.0
mkdir -p $CWD/deps
cd $CWD/deps

wget -nc https://ftp5.gwdg.de/pub/linux/debian/mint/packages/pool/main/h/hypnotix/hypnotix_2.0_all.deb && sudo dpkg -i hypnotix_2.0_all.deb 
#rm -f $CWD/deps/hypnotix_2.0_all.deb

LWD=$HOME/.local/share/powertoys
LBD=$HOME/.local/bin

git clone https://github.com/Silicondust/libhdhomerun.git
cd $CWD/deps/libhdhomerun
make
cp $CWD/deps/libhdhomerun/hdhomerun_config $LBD
cd $CWD/scripts/
clear

LWD=$HOME/.local/share/powertoys
mkdir -p $LWD
cd $CWD
cp -f $CWD/scripts/hdhr_channels.py $LWD
cp -f $CWD/scripts/hypnotix_hdhr.sh $LWD



$LWD/hypnotix_hdhr.sh

