#!/bin/bash 
install_location=/usr/local/bin
config_location=~/.config/
autostart_location=~/.config/autostart

# install requirements
pkgM=$( command -v yum || command -v apt-get || command -v pamac || command -v pacman ) || echo "package manager not found"
case ${pkgM} in
  *pacman)
    install=-S
    auto=--noconfirm
    ;;

  *pamac)
    install=install
    auto=--no-confirm
    ;;

  *)
    install=install 
    auto=-y
    ;;
esac

## cat, stdbuf are builtin, may need to install daemonize by hand
cat pkg_requirements | xargs -n 1 sudo ${pkgM} ${install} ${auto} 
## subprocess, shlex, threading, queue, time, os, sys, math  are builtin
sudo pip3 install pathlib

# place files in corrosponding locations
sudo cp gestures evemu_do getConfig.py ${install_location}
cp gestures.conf ${config_location}
cp gestures.desktop ${autostart_location}

# kill others and start application
sudo pkill libinput-gestures
sudo pkill fusuma 
sudo pkill touchegg
${install_location}/gestures