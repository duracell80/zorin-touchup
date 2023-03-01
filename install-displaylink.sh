#!/usr/bin/bash

CWD=$(pwd)
ZWD=$CWD/deps/displaylink
mkdir -p $ZWD

# https://support.displaylink.com/knowledgebase/articles/684649
# https://www.synaptics.com/products/displaylink-graphics/downloads/ubuntu

sudo apt update
sudo apt dist-upgrade
sudo apt install -y wget unzip
sudo apt install -y dkms
sudo apt install -y libdrm-dev

# GET DISPLAY LINK DRIVERS
cd $ZWD
wget -nc -O $ZWD/displaylink.zip "https://www.synaptics.com/sites/default/files/exe_files/2022-08/DisplayLink USB Graphics Software for Ubuntu5.6.1-EXE.zip"

unzip -n $ZWD/displaylink.zip
RWD=$(ls $ZWD/*.run)
CMD=(sudo $RWD)

"${CMD[@]}"
