#!/bin/bash

# Update the system and install necessary packages
echo "Updating system and installing EPEL and wget..."
sudo dnf update -y
sudo dnf install -y epel-release wget

# Enable and install RabbitMQ from the CentOS RabbitMQ repository
echo "Installing RabbitMQ repository and RabbitMQ server..."
sudo dnf install -y centos-release-rabbitmq-38
sudo dnf --enablerepo=centos-rabbitmq-38 -y install rabbitmq-server

# Enable and start RabbitMQ service
echo "Enabling and starting RabbitMQ service..."
sudo systemctl enable --now rabbitmq-server

# Configure RabbitMQ to allow external access by disabling loopback users
echo "Configuring RabbitMQ to allow external access..."
sudo sh -c 'echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config'

# Add a test user with administrative privileges and set permissions
echo "Adding RabbitMQ user 'test' with administrator privileges..."
sudo rabbitmqctl add_user test test
sudo rabbitmqctl set_user_tags test administrator
sudo rabbitmqctl set_permissions -p / test ".*" ".*" ".*"

# Restart RabbitMQ to apply configurations
echo "Restarting RabbitMQ service to apply changes..."
sudo systemctl restart rabbitmq-server

echo "RabbitMQ setup and configuration completed successfully."
