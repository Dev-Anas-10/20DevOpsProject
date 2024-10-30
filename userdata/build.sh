#!/bin/bash

# Update and install OpenJDK
sudo apt update -y
sudo apt install openjdk-17-jdk -y

# Verify Java installation
java -version

# Install Maven 3.9.9
MAVEN_VERSION=3.9.9
cd /tmp
curl -O https://dlcdn.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz
sudo tar -xzf apache-maven-$MAVEN_VERSION-bin.tar.gz -C /opt
sudo ln -s /opt/apache-maven-$MAVEN_VERSION /opt/maven
sudo ln -s /opt/maven/bin/mvn /usr/bin/mvn

# Verify Maven installation
mvn -version

# Install AWS CLI (direct download)
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Verify AWS CLI installation
aws --version

# Clone or navigate to your Java source code
git clone -b "2.AWS-Cloud-for-Web-App-Setup-Lift&Shift" https://github.com/Dev-Anas-10/20DevOpsProject.git 
cd 20DevOpsProject

# Build the Java project with Maven
export MAVEN_OPTS="-Xmx512m"
mvn clean package

# Find the JAR file
WAR_FILE=$(find target -name "*.war" | head -n 1)

# Push the JAR file to the S3 bucket
aws s3 cp "$WAR_FILE" s3://<YOUR_BUCKET_NAME>/