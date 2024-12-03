#!/bin/bash
sudo -i
# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Disable swap (important for Kubernetes)
sudo swapoff -a
# Comment out swap entry in /etc/fstab to prevent swap from being enabled after reboot
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Load necessary kernel modules for Kubernetes
sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

# Apply the modules
sudo modprobe overlay
sudo modprobe br_netfilter

# Configure sysctl settings for Kubernetes networking
sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

# Apply sysctl settings
sudo sysctl --system

# Install dependencies for Docker and Kubernetes
sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates

# Add Docker's official GPG key and repository
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update package lists and install containerd
sudo apt update
sudo apt install -y containerd.io

# Configure containerd with default settings
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
# Enable systemd as the cgroup driver for containerd
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml

# Restart and enable containerd service
sudo systemctl restart containerd
sudo systemctl enable containerd

# Add Kubernetes repository and GPG key
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Update package lists again and install Kubernetes components
sudo apt update
sudo apt install -y kubelet kubeadm kubectl

# Mark Kubernetes components to hold so they are not upgraded automatically
sudo apt-mark hold kubelet kubeadm kubectl
