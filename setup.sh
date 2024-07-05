#!/bin/bash

# Update and install dependencies
sudo apt-get update
sudo apt-get install -y docker.io docker-compose make

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add vagrant user to docker group
sudo usermod -aG docker vagrant

# Clone your repository (replace with your actual repo URL)
git clone https://github.com/yourusername/your-repo.git /home/vagrant/app
cd /home/vagrant/app

# Build and start the services
make docker-build
make api-start