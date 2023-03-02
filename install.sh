#!/bin/bash

# Check if Docker is installed
if ! command -v docker &> /dev/null
then
    # Install Docker
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    sudo systemctl enable docker
    sudo systemctl start docker
    rm get-docker.sh
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null
then
    # Install Docker Compose
    sudo apt-get update
    sudo apt-get install -y docker-compose
fi

echo "Docker and Docker Compose have been installed successfully!"

#Start Docker containers
sudo docker-compose up -d db web
echo "Now you can use the Query App at localhost:8080"