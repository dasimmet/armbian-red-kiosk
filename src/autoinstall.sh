#!/usr/bin/env bash

set -e
if [ ! -d armbian-red-kiosk ]; then
    git clone https://github.com/dasimmet/armbian-red-kiosk.git
    cd armbian-red-kiosk
else
    cd armbian-red-kiosk
    git pull
fi
./install.sh install
