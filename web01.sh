#!/bin/bash

# Update OS with the latest patches
sudo apt update -y
sudo apt upgrade -y

# Install Nginx
sudo apt install -y nginx

# Create Nginx configuration file
sudo tee /etc/nginx/sites-available/vproapp <<EOF
upstream vproapp {
    server app01:8080;
}
server {
    listen 80;
    location / {
        proxy_pass http://vproapp;
    }
}
EOF

# Remove default Nginx configuration
sudo rm -rf /etc/nginx/sites-enabled/default

# Create link to activate the website
sudo ln -s /etc/nginx/sites-available/vproapp /etc/nginx/sites-enabled/vproapp

# Restart Nginx
sudo systemctl restart nginx

# Check Nginx status
sudo systemctl status nginx
