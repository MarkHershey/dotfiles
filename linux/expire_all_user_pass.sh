#!/usr/bin/env bash

# This script is used to expire the password of all users in the system.

# obtain sudo permissions
sudo -v

# get all users in the system with uid >= 1000 && uid <= 60000
users=$(awk -F':' '{ if ( $3 >= 1000 && $3 <= 60000 ) print $1 }' /etc/passwd)

# exclude current user
current_user=$(whoami)
users=$(echo "$users" | grep -v "$current_user")

# expire password for each user
for user in $users; do
    sudo passwd -e $user > /dev/null && echo "Expired password for user $user"
done
