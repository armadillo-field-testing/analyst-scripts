#!/usr/bin/env bash

# easy system updater for ubuntu/debian systems
# by rick pelletier (galiagante@gmail.com), sept 2017

WHITE=$(tput setaf 7;tput bold)
RED=$(tput setaf 1; tput bold)
GREEN=$(tput setaf 2; tput bold)
YELLOW=$(tput setaf 3; tput bold)
BLUE=$(tput setaf 4; tput bold)
CYAN=$(tput setaf 6; tput bold)
NC=$(tput sgr0)

if [[ $(id -u) -ne 0 ]]
then
  echo
  echo "${RED}This script must run under root privileges${NC}"
  echo
  exit 1
else
  /usr/bin/apt-get update
  /usr/bin/apt-get upgrade

  echo ""
  if [ -f /var/run/reboot-required ]
  then
    echo "${YELLOW}Note: Reboot is required after these upgrades${NC}"
    echo
  else
    echo "${GREEN}No Reboot is currently required${NC}"
    echo
  fi

  echo
fi

# end of script
