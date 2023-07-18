#!/bin/bash

#####################################################################
# This script is used to setup a wired connection with 802.1X security
# Author: Mark H. Huang <dev at markhh dot com>
#####################################################################

# Variables
CONNECTION_NAME="REPLACE_ME"
INTERFACE_NAME="REPLACE_ME" # check 'nmcli device status'
ANONYMOUS_IDENTITY="1000000"

IDENTITY="REPLACE_WITH_YOUR_USERNAME"
PASSWORD="REPLACE_WITH_YOUR_PASSWORD"

# Install NetworkManager and its dependencies
# sudo apt-get update
# sudo apt-get install network-manager network-manager-gnome -y


# add a new wired connection
nmcli con add con-name $CONNECTION_NAME type ethernet ifname $INTERFACE_NAME 

# set static ip address
# nmcli con modify $CON_NAME ipv4.addresses "192.0.2.2/24" ipv4.gateway "192.0.2.1" ipv4.method manual

# set DNS server
# nmcli con modify $CON_NAME ipv4.dns "8.8.8.8,8.8.4.4"

# Enable automatic connection on startup
nmcli con modify $CON_NAME connection.autoconnect yes

# Set autoconnect priority
# nmcli con modify $CON_NAME connection.autoconnect-priority -999 # -999 (lowest) to 999 (highest)

# Configure 802.1X security
nmcli con modify $CONNECTION_NAME 802-1x.anonymous-identity $ANONYMOUS_IDENTITY
nmcli con modify $CONNECTION_NAME 802-1x.identity $IDENTITY
nmcli con modify $CONNECTION_NAME 802-1x.password $PASSWORD
nmcli con modify $CONNECTION_NAME 802-1x.eap peap
nmcli con modify $CONNECTION_NAME 802-1x.phase2-auth mschapv2

# Restart the NetworkManager service to apply the changes
sudo systemctl restart NetworkManager

# Connect to the wireless network
nmcli con up $CONNECTION_NAME

# Check the connection status
nmcli con show --active
