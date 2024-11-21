# Use the official MySQL image as a base
FROM mysql

# Set environment variables
ENV MYSQL_DATABASE=accounts
ENV MYSQL_ROOT_PASSWORD=admin123

# Copy the SQL schema file into the initialization directory
COPY db_backup.sql /docker-entrypoint-initdb.d/

# Optional: Run additional commands if needed
# Example:
# RUN apt-get update && apt-get install -y some-package

# Expose the MySQL default port
EXPOSE 3306

# Start MySQL server when the container launches
CMD ["mysqld"]
