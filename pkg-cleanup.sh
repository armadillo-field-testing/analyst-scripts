#!/usr/bin/env bash

# ref: https://raymii.org/s/tutorials/Debian-apt-get-dpkg-packages-cleanup-commands.html

if [[ $(id -u) -ne 0 ]]
then
  echo
  echo "This script must run under root privileges"
  echo
  exit 1
else
  # purge (completely remove) packages that are in 'rc' mode
  apt-get purge -y $(dpkg --list | grep '^rc' | awk '{print $2}')

  # this will (hopefully) clean up stragglers and free up remaining space
  apt-get autoremove -y
  apt-get clean -y
fi

# end of script
