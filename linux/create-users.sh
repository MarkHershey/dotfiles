#!/usr/bin/env bash

# Define a list of new usernames
new_users=(
jake
mike
david
linus
)

# Loop through the list of usernames
for username in "${new_users[@]}"; do
  # Check if the user already exists
  if id -u "$username" > /dev/null 2>&1; then
    # If the user exists, print a message and skip to the next iteration
    echo "User $username already exists. Skipping..."
    echo "User $username already exists." >> new_users.tmp
    continue
  fi

  # Generate a moderate random password for the new user
  password=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c8)

  # Create the new user with the generated password
  useradd -m -p "$password" "$username"

  # Save the result (success with password) to the file "new_users.tmp"
  echo "Created User $username with Password $password" >> new_users.tmp
done

# Print the results
cat new_users.tmp