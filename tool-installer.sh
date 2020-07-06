#!/usr/bin/env bash

# tool installer for ubuntu/debian systems
# by rick pelletier (galiagante@gmail.com), sept 2017


WHITE=$(tput setaf 7;tput bold)
RED=$(tput setaf 1; tput bold)
GREEN=$(tput setaf 2; tput bold)
YELLOW=$(tput setaf 3; tput bold)
BLUE=$(tput setaf 4; tput bold)
CYAN=$(tput setaf 6; tput bold)
NC=$(tput sgr0)


apps=("curl" "wget" "tmux" "vim" "nano" "git" "htop" "nmap" "silversearcher-ag" "clamav")


if [[ $(id -u) -ne 0 ]]
then
  echo
  echo "${RED}This script must run under root privileges${NC}"
  echo
  exit 1
else
  echo
  echo "${CYAN}Installing supplemental apps${NC}"
  echo

  for k in ${apps[@]}
  do
    echo -n "${GREEN}Checking for ${k}: "
    if dpkg --list | grep -i ${k} > /dev/null
    then
      echo "PRESENT (skipped)${NC}"
    else
      echo "${YELLOW}NOT PRESENT (installing)${NC}"
      sudo apt -y install ${k}
    fi
  done

  echo
  echo "${CYAN}Installation process complete${NC}"
fi
echo


# clamav handler for forced freshclam update
echo "${CYAN}Updating ClamAV db${NC}"
systemctl stop clamav-freshclam
freshclam
systemctl start clamav-freshclam
echo "${CYAN}Update complete${NC}"
echo


# download and install maldet (after presence check)
maldet_url="https://www.rfxn.com/downloads/maldetect-current.tar.gz"
target_dir="/root"

echo "${CYAN}Installing maldet${NC}"

if [ -x /usr/local/sbin/maldet ]
then
  echo "${GREEN}Already Present (skipped)${NC}"
else
  echo "${GREEN}Downloading maldet${NC}"
  wget -q -O - "${maldet_url}" | tar -xzf - -C ${target_dir}
  echo "${GREEN}Download complete${NC}"

  echo "${GREEN}installing maldet${NC}"
  maldet_dir=$(find ${target_dir} -type d -name "maldet*" | head -n 1)
  cd ${maldet_dir}
  ./install.sh
  echo "${GREEN}Installation complete${NC}"
fi
echo
echo "${CYAN}Supplemental apps installed${NC}"

# end of script
