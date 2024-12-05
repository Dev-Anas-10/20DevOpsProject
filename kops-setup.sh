#!/bin/bash

# Create an RSA key pair with default settings
#mkdir -p /home/vagrant/.ssh
#ssh-keygen -t rsa -b 3072 -N "" -f /home/vagrant/.ssh/id_rsa
#echo "SSH key has been generated and saved in /home/vagrant/.ssh/id_rsa"
# Update system packages
sudo apt update -y

# Install AWS CLI
sudo apt install -y awscli
#sudo snap install aws-cli --classic

# Setting up AWS credentials and configuration variables
#aws configure

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
#chmod +x ./kubectl
#sudo mv ./kubectl /usr/local/bin/kubectl

# Check if kubectl was installed successfully
kubectl version

# Install kops
#curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
#chmod +x kops
#sudo mv kops /usr/local/bin/kops
wget https://github.com/kubernetes/kops/releases/download/v1.26.4/kops-linux-amd64
chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops

# Check if kops was installed successfull
kops version