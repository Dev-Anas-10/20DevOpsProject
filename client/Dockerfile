# Use Node.js image for the build environment
FROM node:14 AS build

# Create and set the working directory
WORKDIR /app

# Copy project files into the working directory
COPY ./ ./client

# Install dependencies and build the application
WORKDIR /app/client

RUN npm install
RUN npm run build --prod

# Use Nginx as the web server
FROM nginx

# Copy the build output from the build stage to the Nginx directory
COPY --from=build /app/client/dist/client/ /usr/share/nginx/html

# Copy a custom Nginx configuration file if needed
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 8080 to serve the application
EXPOSE 8080

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
