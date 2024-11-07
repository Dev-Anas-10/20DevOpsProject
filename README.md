# Containerization of Microservice app using Docker

## Project Overview
This project demonstrates the containerization of an application named **EmartApp** using Docker. The architecture consists of three main components, each running in its own Docker container:

1. **Client**: A front-end application built with Angular, served on the root path (`/`).
2. **Emart API**: A Node.js API that provides application services, available at the path `/api`, and connected to a MongoDB database.
3. **Books API**: A Java-based API available at the path `/webapi`, connected to a MySQL database.

The services are managed through Nginx, acting as an API gateway to route requests to the appropriate services.

## Architecture
The following image illustrates the architecture of the EmartApp:

![Emart App Architecture](project-flow.png)

### Architecture Details
- **Nginx**: Functions as an API Gateway and routes requests to different components:
  - `/` - Routes requests to the Angular client application.
  - `/api` - Routes requests to the Emart API (Node.js) for application services.
  - `/webapi` - Routes requests to the Books API (Java) for book-related services.

## Prerequisites
- Docker and Docker Compose installed on your machine.
- MongoDB and MySQL databases accessible from the containers, or included as containers within the Docker Compose configuration.
