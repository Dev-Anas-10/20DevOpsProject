#!/bin/bash

# Variables
DB_NAME="accounts"
DB_USER="admin"
DB_PASSWORD="admin123"

# Log into MariaDB and execute SQL commands
sudo mysql -u root <<EOF
CREATE DATABASE ${DB_NAME};
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
FLUSH PRIVILEGES;
EXIT;
EOF

echo "Database '${DB_NAME}' created and privileges granted to user '${DB_USER}'."
