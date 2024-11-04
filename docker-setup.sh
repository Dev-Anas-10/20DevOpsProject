#!/bin/bash

# Update the package lists
sudo apt-get update

# Install necessary dependencies
sudo apt-get install -y ca-certificates curl

# Add Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the Docker repository to Apt sources
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package lists again after adding Docker repository
sudo apt-get update

# Install Docker Engine, CLI, and other necessary components non-interactively
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add the 'ubuntu' user to the 'docker' group to avoid needing sudo
sudo usermod -aG docker ubuntu

# Download Docker Compose standalone binary and make it executable
curl -SL https://github.com/docker/compose/releases/download/v2.29.6/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Print Docker and Docker Compose versions to confirm installation
docker --version
docker-compose --version

# docker-compose down --volumes                  # To delete all containers
# docker system prune -a --volumes               # To delete all thing