# Use the official Maven image to build the application
FROM maven:3.8.5-openjdk-8 AS build

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the pom.xml file and install dependencies
COPY ./ ./javaapi

# Package the application
WORKDIR /usr/src/app/javaapi

RUN mvn clean package -DskipTests

# Use the official OpenJDK image to run the application
FROM openjdk:8

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the packaged jar from the build stage
COPY --from=build /usr/src/app/javaapi/target/*.jar ./app.jar

# Expose the port that the application runs on (e.g., 9000)
EXPOSE 9000

# Command to run the application
CMD ["java", "-jar", "app.jar"]
