# Use the official NGINX image as a base
FROM nginx

RUN rm -rf /etc/nginx/conf.d/default.conf

# Copy the custom nginx.conf file to the container
COPY nginvproapp.conf /etc/nginx/conf.d/nginx.conf

# Expose the default NGINX port
EXPOSE 80

# Start NGINX
CMD ["nginx-debug", "-g", "daemon off;"]
