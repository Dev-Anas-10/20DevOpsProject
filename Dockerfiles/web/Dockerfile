# Use the official NGINX image as a base
FROM nginx:latest

# Remove the default Nginx configuration file
RUN rm -rf /etc/nginx/conf.d/default.conf

# Copy the custom Nginx configuration file to the container
COPY nginx.conf /etc/nginx/conf.d/nginx.conf

# Expose the default NGINX port
EXPOSE 80

