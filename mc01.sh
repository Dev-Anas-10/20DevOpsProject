#!/bin/bash

# Update system and install required packages
echo "Updating system and installing Memcached..."
sudo dnf update -y
sudo dnf install -y epel-release
sudo dnf install -y memcached libevent

# Start and enable Memcached service
echo "Starting and enabling Memcached service..."
sudo systemctl start memcached
sudo systemctl enable memcached

# Configure Memcached to listen on all network interfaces
echo "Configuring Memcached to listen on all interfaces..."
sudo sed -i 's/-l 127.0.0.1/-l 0.0.0.0/' /etc/sysconfig/memcached

# Restart Memcached service to apply changes
echo "Restarting Memcached service to apply configuration changes..."
sudo systemctl restart memcached

# Run Memcached with specified options
echo "Starting Memcached with custom options..."
sudo memcached -p 11211 -U 11111 -u memcached -d

echo "Memcached setup completed successfully."
