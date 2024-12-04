# Step 1: Build the application using Maven
FROM maven:3.9.9-amazoncorretto-21 AS builder

# Set the working directory
WORKDIR /app

# Clone the GitHub repository (replace the URL with your repository)
COPY ../../ ./

# Set the working directory
WORKDIR /app

# List files to verify if pom.xml is present
RUN ls -la

# Build the application
RUN mvn clean install

# Step 2: Copy the artifact to the Tomcat container
FROM tomcat:latest

RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the artifact from the builder stage to the Tomcat webapps directory
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose the Tomcat port
EXPOSE 8080

# Start Tomcat when the container launches
CMD ["catalina.sh", "run"]
