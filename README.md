# Containerization-of-Java-project-using-Docker

## Project Overview
This project is designed to demonstrate a full-stack application deployment using Docker, NGINX, RabbitMQ, Memcached, and a relational database. The architecture follows the microservices pattern, where each component is containerized and orchestrated to work together seamlessly.

## Project Flow
![Project Flow](project-flow.png)

## Technologies Used
- **Docker**: For containerization of all components.
- **NGINX**: As a reverse proxy server.
- **RabbitMQ**: For message brokering.
- **Memcached**: For caching layer.
- **MySQL**: As the relational database.

## Components
- **Web Server**: Built using NGINX, it handles HTTP requests and serves static files.
- **Application Server**: A Java-based application running on Tomcat (app01).
- **Database Server**: MySQL database for persistent storage.
- **Message Broker**: RabbitMQ for handling asynchronous messaging.
- **Caching Layer**: Memcached to enhance performance by caching frequently accessed data.

## Getting Started
To run the application locally, follow these steps:

### Prerequisites
- Docker installed on your machine.
- Docker Compose (optional, for easier multi-container management).

### Build the Images
To build the Docker images, navigate to your project directory and run:

```bash
docker-compose build
