#!/bin/bash

# Update the system
sudo dnf update -y

# Install EPEL repository
sudo dnf install epel-release -y

# Install Erlang
sudo dnf install erlang -y

# Install RabbitMQ
sudo dnf install rabbitmq-server -y

# Enable and start RabbitMQ service
sudo systemctl enable rabbitmq-server
sudo systemctl start rabbitmq-server

# Check the status of RabbitMQ
sudo systemctl status rabbitmq-server

# Enable RabbitMQ Management Plugin
sudo rabbitmq-plugins enable rabbitmq_management

# Create a new user with username 'test' and password 'test'
sudo rabbitmqctl add_user test test

# Set the user permissions for the 'test' user
sudo rabbitmqctl set_user_tags test administrator
sudo rabbitmqctl set_permissions -p / test ".*" ".*" ".*"

