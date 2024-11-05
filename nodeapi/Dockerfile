# Use the official Node.js image as a base image
FROM node:14

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json files to the working directory
COPY ./ ./nodeapi

# Install the application dependencies
WORKDIR /usr/src/app/nodeapi
RUN npm install

# Expose the port that the app runs on
EXPOSE 5000

# Command to run the application
CMD ["node", "server.js"]
