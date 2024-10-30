#!/bin/bash

# Update OS with the latest patches
echo "Updating system..."
dnf update -y

# Set up the EPEL repository
echo "Installing EPEL repository..."
dnf install epel-release -y

# Install required dependencies
echo "Installing Java, Git, and Wget..."
dnf -y install java-17-openjdk java-17-openjdk-devel git wget

# Change to /tmp directory
cd /tmp/

# Download and extract the Tomcat package
echo "Downloading and extracting Apache Tomcat..."
wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.26/bin/apache-tomcat-10.1.26.tar.gz
tar xzvf apache-tomcat-10.1.26.tar.gz

# Create a Tomcat user
echo "Adding Tomcat user..."
useradd --home-dir /usr/local/tomcat --shell /sbin/nologin tomcat

# Copy Tomcat files to the installation directory and set permissions
echo "Setting up Tomcat directories and permissions..."
cp -r /tmp/apache-tomcat-10.1.26/* /usr/local/tomcat/
chown -R tomcat:tomcat /usr/local/tomcat

# Create a systemd service file for Tomcat
echo "Creating Tomcat systemd service file..."
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

# Reload systemd and start Tomcat service
echo "Starting and enabling Tomcat service..."
systemctl daemon-reload
systemctl start tomcat
systemctl enable tomcat

# Maven Setup
echo "Downloading and setting up Maven..."
cd /tmp/
wget https://archive.apache.org/dist/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.zip
unzip apache-maven-3.9.9-bin.zip
cp -r apache-maven-3.9.9 /usr/local/maven3.9
export MAVEN_OPTS="-Xmx512m"

# Clone project and build using Maven
echo "Cloning project repository and building with Maven..."
cd /tmp/
git clone -b 1.Multi-Tier-Web-Application-Setup,-Locally https://github.com/Dev-Anas-10/20DevOpsProject.git
cd 20DevOpsProject
/usr/local/maven3.9/bin/mvn install

# Deploy project to Tomcat
echo "Deploying project to Tomcat..."
systemctl stop tomcat
rm -rf /usr/local/tomcat/webapps/ROOT*
cp target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
chown -R tomcat:tomcat /usr/local/tomcat/webapps
systemctl start tomcat
systemctl restart tomcat

echo "Tomcat and Maven setup completed successfully."
