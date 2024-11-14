#!/bin/bash

# Update package list
sudo apt update
sudo apt upgrade -y

# Install JDK 11
sudo apt install openjdk-11-jdk -y

# Download Jenkins key and store it in keyring
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

# Add Jenkins repository to the sources list
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package list again
sudo apt-get update

# Install Jenkins
sudo apt-get install jenkins -y

echo "Administrator password of jenkins is "
echo "###############################################"
cat /var/lib/jenkins/secrets/initialAdminPassword
echo "###############################################"

# User & password
# user : admin
# password : admin