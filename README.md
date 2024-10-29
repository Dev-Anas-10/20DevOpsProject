# Java Application Project

![Project Architecture](Project-Architecture.png)

This project was created using Vagrant on VirtualBox to set up a local environment with five virtual machines (VMs) for the following services:
- **MySQL Database**: To store data
- **RabbitMQ**: For inter-service communication
- **Memcached**: Caching for faster data processing
- **Tomcat**: Server to run the Java application
- **Nginx**: Reverse proxy for routing requests between services

## Project Overview

The user starts by accessing the interface through Nginx, which directs requests to Tomcat. From there, the setup interacts with RabbitMQ and Memcached, then accesses the MySQL Database to perform necessary data operations.

### Connection Between Virtual Machines:
1. **Nginx**: Receives user requests and routes them to Tomcat.
2. **Tomcat**: Processes requests and connects to RabbitMQ for message exchange.
3. **RabbitMQ**: Facilitates communication with Memcached and MySQL as needed.
4. **Memcached**: Used for caching temporary data.
5. **MySQL**: The primary database for data storage.

![Project Flow](project-flow.png)

## Requirements
- **Vagrant** and **VirtualBox** installed on your machine.

## Getting Started
1. Ensure you're in the project folder.
2. Run `vagrant up` to start all virtual machines.
3. Once setup is complete, you can access the application via Nginx, which will direct you to Tomcat, then to the other services as required.

---

Thank you for using our project!
