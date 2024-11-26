#!/bin/bash

# Enable firewall and allow port 8081 for Nexus
#sudo firewall-cmd --zone=public --add-port=8081/tcp --permanent
#sudo firewall-cmd --reload

# Install required packages
sudo yum install java-17-openjdk.x86_64 wget -y

# Create necessary directories
sudo mkdir -p /opt/nexus/
sudo mkdir -p /tmp/nexus/
sudo chmod 777 /tmp/nexus/
sudo chmod 777 /opt/nexus/
cd /tmp/nexus/

# Download Nexus archive
NEXUSURL="https://download.sonatype.com/nexus/3/latest-unix.tar.gz"
wget $NEXUSURL -O nexus.tar.gz || { echo "Failed to download Nexus"; exit 1; }

# Extract Nexus archive
tar xzvf nexus.tar.gz || { echo "Failed to extract Nexus"; exit 1; }
NEXUSDIR=$(ls -d nexus*/ | grep '^nexus' | cut -d '/' -f1)

# Move extracted files to the target directory
sudo rm -rf /tmp/nexus/nexus.tar.gz
sudo cp -r /tmp/nexus/* /opt/nexus/
rm -rf /tmp/nexus

# Create Nexus user
sudo useradd nexus
sudo chown -R nexus:nexus /opt/nexus

# Create a systemd service for Nexus
sudo bash -c "cat <<EOT > /etc/systemd/system/nexus.service
[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/$NEXUSDIR/bin/nexus start
ExecStop=/opt/nexus/$NEXUSDIR/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOT"

# Configure Nexus to run as the nexus user
echo 'run_as_user="nexus"' | sudo tee /opt/nexus/$NEXUSDIR/bin/nexus.rc

# Reload systemd configuration
sudo systemctl daemon-reload

# Start Nexus service
sudo systemctl start nexus || { echo "Failed to start Nexus"; exit 1; }

# Enable Nexus service to start on boot
sudo systemctl enable nexus || { echo "Failed to enable Nexus"; exit 1; }

echo "Nexus setup completed successfully."
