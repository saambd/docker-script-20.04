# docker-script #
- - - -
Script that automatically installs and sets up docker on Ubuntu 20.04 Linux
You can run this by doing the command 
 
    bash <(curl -s https://raw.githubusercontent.com/saambd/docker-script-20.04/main/script.sh)

## Requirements ##
This script is designed to be run on a fresh install of ubuntu 20.04, if you already installed docker it has a chance of breaking.

## What the script does ##
When you run this script:
1. It will first verify you are using Ubuntu 20.04, then it will verify if you are running it with Root Privileges
2. It will run the normal system updates
3. It will add the docker repo to the repository list
4. It will then install the latest version of docker and docker-compose
5. It will then install the latest Portainer
