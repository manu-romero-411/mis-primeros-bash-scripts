#!/bin/bash

cp /etc/skel/.bash_logout ~
cp /etc/skel/.bashrc ~
cp /etc/skel/.profile ~
cp /etc/skel/.Xdefaults ~
cp /etc/skel/.xscreensaver ~
sudo ./reinstalacion-xubuntu-32.sh
exit 0