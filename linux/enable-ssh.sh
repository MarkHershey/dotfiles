#!/bin/bash

# Check if SSH service is installed
if ! dpkg -s openssh-server &> /dev/null; then
  echo "SSH is not installed. Installing now..."
  sudo apt-get update
  sudo apt-get install -y openssh-server
fi

# Check if SSH service is enabled
if systemctl is-active --quiet ssh; then
  echo "SSH is enabled."
else
  echo "SSH is not enabled. Enabling now..."
  sudo systemctl enable ssh
  sudo systemctl start ssh
fi