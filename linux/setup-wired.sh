#!/bin/bash

#####################################################################
# This script is used to setup a wired connection with 802.1X security
# Author: Mark H. Huang <dev at markhh dot com>
# 
# This script assumes that 
#   1. you are running Ubuntu 
#   2. you have already installed NetworkManager
#####################################################################

# Variables
CONNECTION_NAME="REPLACE_ME"
INTERFACE_NAME="REPLACE_ME" # check 'nmcli device status'
ANONYMOUS_IDENTITY="1000000"

IDENTITY="REPLACE_ME"
PASSWORD="REPLACE_ME"

# Check if nmcli is installed
if ! command -v nmcli &> /dev/null; then
    echo "Command 'nmcli' could not be found. Please install it and try again."
    echo ">>> sudo apt-get update && apt-get install network-manager network-manager-gnome -y"
    exit 1
fi

# remove all existing connection profiles
echo "Are you sure you want to delete all network connection profiles? This cannot be undone. [y/N]"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    nmcli --fields UUID connection show | awk 'NR>1' | xargs -r nmcli connection delete
else
    echo "Operation cancelled."
    exit 1
fi

# add a new wired connection
nmcli con add con-name $CONNECTION_NAME type ethernet ifname $INTERFACE_NAME 

# Configure 802.1X security
nmcli con modify $CONNECTION_NAME 802-1x.eap peap 802-1x.phase2-auth mschapv2 802-1x.anonymous-identity $ANONYMOUS_IDENTITY 802-1x.identity $IDENTITY 802-1x.password $PASSWORD

# Enable automatic connection on startup
nmcli con modify $CONNECTION_NAME connection.autoconnect yes

# Set autoconnect priority
# nmcli con modify $CONNECTION_NAME connection.autoconnect-priority 0 # -999 (lowest) to 999 (highest)

# set DNS server
# nmcli con modify $CON_NAME ipv4.dns "8.8.8.8,8.8.4.4"

# Restart the NetworkManager service to apply the changes
echo "Restarting NetworkManager service..."
sudo systemctl restart NetworkManager

# Connect to the wireless network
echo "Connecting to the network..."
nmcli con up $CONNECTION_NAME

# Check the connection status
echo "Connection status:"
nmcli con show --active
