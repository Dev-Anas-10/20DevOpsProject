#!/bin/bash

# Update OS with latest patches
dnf update -y

# Set Repository
dnf install epel-release -y

# Install Dependencies
dnf -y install java-17-openjdk java-17-openjdk-devel
dnf install git wget -y

# Change dir to /tmp
cd /tmp/

# Download Tomcat Package
wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.26/bin/apache-tomcat-10.1.26.tar.gz

# Extract Tomcat Package
tar xzvf apache-tomcat-10.1.26.tar.gz

# Add Tomcat user
useradd --home-dir /usr/local/tomcat --shell /sbin/nologin tomcat

# Copy data to tomcat home dir
cp -r /tmp/apache-tomcat-10.1.26/* /usr/local/tomcat/

# Make tomcat user owner of tomcat home dir
chown -R tomcat.tomcat /usr/local/tomcat

# Setup systemctl command for Tomcat
# Create tomcat service file
cat <<EOL > /etc/systemd/system/tomcat.service
[Unit]
Description=Tomcat
After=network.target

[Service]
User=tomcat
Group=tomcat
WorkingDirectory=/usr/local/tomcat
Environment=JAVA_HOME=/usr/lib/jvm/java-17-openjdk
Environment=CATALINA_PID=/var/tomcat/run/tomcat.pid
Environment=CATALINA_HOME=/usr/local/tomcat
Environment=CATALINA_BASE=/usr/local/tomcat
ExecStart=/usr/local/tomcat/bin/catalina.sh run
ExecStop=/usr/local/tomcat/bin/shutdown.sh
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd files
systemctl daemon-reload

# Start & Enable service
systemctl start tomcat
systemctl enable tomcat

echo "Tomcat installation completed successfully."
