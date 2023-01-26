#!/bin/bash

# Set the SSID and password for the wireless network
SSID="XXXXXX"
USERNAME="XXXXXX"
PASSWORD="XXXXXXXXXXXX"
DOMAIN="XXXXXX"
anonymous_identity="XXXXXX"

# Install NetworkManager and its dependencies
sudo apt-get update
sudo apt-get install network-manager network-manager-gnome -y

# Configure the wireless network using NetworkManager
nmcli con add type wifi ifname wlan0 con-name $SSID ssid $SSID
nmcli con modify $SSID wifi-sec.key-mgmt wpa-eap
nmcli con modify $SSID 802-1x.eap peap
nmcli con modify $SSID 802-1x.phase2-auth mschapv2
nmcli con modify $SSID 802-1x.identity $USERNAME
nmcli con modify $SSID 802-1x.password $PASSWORD
nmcli con modify $SSID connection.autoconnect yes
nmcli con modify $SSID 802-1x.anonymous-identity $anonymous_identity
nmcli con modify $SSID 802-1x.domain-suffix-match $DOMAIN
# nmcli con modify $SSID wifi-sec.auth-alg open

nmcli con modify $SSID ipv4.method auto
nmcli con modify $SSID ipv6.method auto

# Restart the NetworkManager service to apply the changes
sudo systemctl restart NetworkManager

# Connect to the wireless network
nmcli con up $SSID

# Check the connection status
nmcli con show --active