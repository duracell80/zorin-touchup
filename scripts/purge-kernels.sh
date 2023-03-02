#!/usr/bin/bash

uname -r
sudo dpkg --list | egrep -i --color 'linux-image|linux-headers|linux-modules'
#sudo apt remove --purge linux-headers-5.14.8-051408
sudo apt autoremove --purge
sudo apt update && sudo apt upgrade
