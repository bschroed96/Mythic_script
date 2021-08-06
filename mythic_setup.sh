#!/bin/sh

git clone https://github.com/its-a-feature/Mythic.git
cd Mythic

if [-x "$(command -v docker)" ]; then
        echo "Docker installed"
else
        echo "Docker not installed, running docker install script"
        ./install_docker_ubuntu.sh
fi
# Make sure no previous services are running/exist.
echo "Purging docker and docker-compose to avoid port/naming collisions"
docker-compose down
docker container prune
docker images prune

# Install Mythic and agents/profiles
echo "Installing Mythic and agents / profiles"
sudo ./mythic-cli mythic start
sudo ./mythic-cli install github https://github.com/MythicAgents/Apollo.git
sudo ./mythic-cli install github https://github.com/MythicAgents/Medusa.git
sudo ./mythic-cli install github https://github.com/MythicAgents/venus.git
sudo ./mythic-cli install github https://github.com/MythicC2Profiles/http
sudo ./mythic-cli install github https://github.com/MythicC2Profiles/dynamichttp
sudo ./mythic-cli install github https://github.com/MythicC2Profiles/dns
sudo ./mythic-cli install github https://github.com/MythicC2Profiles/websocket
