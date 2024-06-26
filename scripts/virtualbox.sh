#!/bin/bash

# Update package list and install dependencies
sudo apt update
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Download and add Oracle VirtualBox repository key
curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmor -o /usr/share/keyrings/virtualbox-archive-keyring.gpg

# Add VirtualBox repository
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/virtualbox-archive-keyring.gpg] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list > /dev/null

# Update package list again to include VirtualBox repository
sudo apt update

# Install VirtualBox
sudo apt install -y virtualbox-6.1

# Optional: Install Extension Pack (uncomment the line below to install)
# sudo apt install -y virtualbox-ext-pack

# Optional: Add user to vboxusers group for USB support
sudo usermod -aG vboxusers $USER

echo "VirtualBox installed successfully!"
