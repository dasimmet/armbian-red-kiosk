#!/usr/bin/env bash

set -e
if [ ! -d armbian-red-kiosk ]; then
    apt-get update
    apt-get full-upgrade -y
    apt-get install -y git
    git clone https://github.com/dasimmet/armbian-red-kiosk.git
    cd armbian-red-kiosk
else
    cd armbian-red-kiosk
fi
./install.sh install
