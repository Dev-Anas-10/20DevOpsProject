#!/bin/bash

# Variables
DB_NAME="accounts"
DB_USER="admin"
DB_PASSWORD="admin123"
ROOT_PASSWORD="admin123"
REPO_URL="https://github.com/Dev-Anas-10/20DevOpsProject.git"
BRANCH="1.Multi-Tier-Web-Application-Setup,-Locally"
DB_BACKUP="src/main/resources/db_backup.sql"

# Function to update the system and install required packages
install_packages() {
  echo "Updating system and installing packages..."
  sudo dnf update -y
  sudo dnf install epel-release -y
  sudo dnf install mariadb-server git -y
}

# Function to start and enable MariaDB service
configure_mariadb_service() {
  echo "Starting and enabling MariaDB service..."
  sudo systemctl start mariadb
  sudo systemctl enable mariadb
}

# Function to configure the database and user
configure_database() {
  echo "Configuring database and user..."
  sudo mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';
FLUSH PRIVILEGES;
CREATE DATABASE ${DB_NAME};
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
FLUSH PRIVILEGES;
EXIT;
EOF
  echo "Database '${DB_NAME}' created and privileges granted to user '${DB_USER}'."
}

# Function to clone the repository and import the database
clone_and_import_repo() {
  echo "Cloning repository and importing database..."
  git clone -b ${BRANCH} ${REPO_URL}
  cd 20DevOpsProject || exit
  mysql -u root -p${ROOT_PASSWORD} ${DB_NAME} < ${DB_BACKUP}
}

# Function to restart MariaDB service
restart_mariadb() {
  echo "Restarting MariaDB service..."
  sudo systemctl restart mariadb
}

# Main function to execute all steps
main() {
  install_packages
  configure_mariadb_service
  configure_database
  clone_and_import_repo
  restart_mariadb
  echo "Setup completed successfully."
}

# Call the main function
main
