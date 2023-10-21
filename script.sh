#!/bin/bash

# Some Global Variables
osVersion="$(lsb_release -a 2> /dev/null | grep Desc | sed -e 's/.*://' -e 's/^[ \t]*//')"

# Some colours that are used throughout the script
LIGHT_RED='\033[1;31m'
RED='\033[0;31m'
LIGHT_DARK_GRAY='\033[0;96m'
BLUE='\033[1;34m'
DARK_GRAY='\033[0;37m'
LIGHT_GREEN='\033[1;32m'
NoColor='\033[0m'

# Initial Checks to make sure the script can run
[[ $EUID -ne 0 ]] && echo -e ""$RED"Error: Please run this script with root privileges (sudo)"$NoColor"" && exit 1
[[ -z $(echo $osVersion | grep 'Ubuntu 20') ]] && echo -e ""$RED"Error: This script must be ran with Ubuntu 20.04"$NoColor"" && exit 1

# Updating the system packages to make sure you have the correct versions of everything
runSystemUpdates() {
    clear && echo -e "\n\t${DARK_GRAY}Updating System Repositories...${NoColor}" && sleep 3
    apt update
    sleep 3 && clear && echo -e "\n\t${DARK_GRAY}Updating System...${NoColor}" && sleep 3
    apt upgrade -y
}

# Installing latest version of Docker and DockerCompose
installDocker() {
    sleep 3 && clear && echo -e "\n\t${DARK_GRAY}Installing Key Dependencies...${NoColor}" && sleep 3
    apt install apt-transport-https ca-certificates curl software-properties-common git -y
    sleep 3 && clear && echo -e "\n\t${DARK_GRAY}Adding Docker Updated Repositories...${NoColor}" && sleep 3
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
    apt-cache policy docker-ce
    sleep 3 && clear && echo -e "\n\t${DARK_GRAY}Installing Docker and Docker-Compose...${NoColor}" && sleep 3
    apt install docker-ce docker-compose -y
}

# Installing latest version of Portainer
installPortainer() {
    sleep 3 && clear && echo -e "\n\t${DARK_GRAY}Installing Portainer...${NoColor}" && sleep 3
    docker volume create portainer_data
    docker run -d -p 9000:9000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
}

runSystemUpdates
installDocker
installPortainer
