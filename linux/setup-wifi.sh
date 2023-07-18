#!/bin/bash

#####################################################################
# This script is used to setup a wireless connection with 802.1X security
# Author: Mark H. Huang <dev at markhh dot com>
# Date: 2023-07-18
# 
# This script assumes that 
#   1. you are running Ubuntu 
#   2. you have already installed NetworkManager
#####################################################################

CONNECTION_NAME="REPLACE_ME"
INTERFACE_NAME="REPLACE_ME"
SSID="REPLACE_ME"

EAP_METHOD="peap"
PHASE2_AUTH="mschapv2"
DOMAIN="REPLACE_ME"

IDENTITY="REPLACE_ME"
PASSWORD="REPLACE_ME"
ANONYMOUS_IDENTITY="REPLACE_ME"

# Add new Wi-Fi connection
nmcli con add con-name $CONNECTION_NAME type wifi ifname $INTERFACE_NAME ssid $SSID

# Set Wi-Fi security options
nmcli con modify $CONNECTION_NAME wifi-sec.key-mgmt wpa-eap

# Set 802.1x security options
nmcli con modify $CONNECTION_NAME 802-1x.eap $EAP_METHOD
nmcli con modify $CONNECTION_NAME 802-1x.phase2-auth $PHASE2_AUTH
nmcli con modify $CONNECTION_NAME 802-1x.domain-suffix-match $DOMAIN
nmcli con modify $CONNECTION_NAME 802-1x.identity $IDENTITY
nmcli con modify $CONNECTION_NAME 802-1x.password $PASSWORD

# Enable automatic connection on startup
nmcli con modify $CONNECTION_NAME connection.autoconnect yes

# Set autoconnect priority
# nmcli con modify $CONNECTION_NAME connection.autoconnect-priority 0 # -999 (lowest) to 999 (highest)

# set DNS server
# nmcli con modify $CON_NAME ipv4.dns "8.8.8.8,8.8.4.4"

# Set IPv4 and IPv6 settings
nmcli con modify $CONNECTION_NAME ipv4.method auto
nmcli con modify $CONNECTION_NAME ipv6.addr-gen-mode stable-privacy
nmcli con modify $CONNECTION_NAME ipv6.method auto

# Restart the NetworkManager service to apply the changes
echo "Restarting NetworkManager service..."
sudo systemctl restart NetworkManager

# Connect to the wireless network
echo "Connecting to the network..."
nmcli con up $CONNECTION_NAME

# Check the connection status
echo "Connection status:"
nmcli con show --active