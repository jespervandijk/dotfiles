#!/bin/bash
#
# .SYNOPSIS
#    Installs applications using apt.
#
# .DESCRIPTION
#    This script installs a list of applications using the apt package manager on Ubuntu.
#    It first updates the apt package lists and then installs the specified applications.
#
# .NOTES
#    - Requires Ubuntu or Debian-based system.
#    - Requires administrative privileges (sudo) to install applications.

# Update apt package lists
echo "Updating apt package lists..."
sudo apt update

if [ $? -ne 0 ]; then
  echo "Failed to update apt package lists.  Exiting."
  exit 1
fi

# Define the list of application names to install
app_names=(
  "git"
  "zsh"
  "tmux"
  "dotnet-sdk-9.0"
  "dotnet-sdk-8.0"
  "curl"
)

# ! nvm in installed via curl

# Install each application using apt
for app_name in "${app_names[@]}"
do
  echo "Installing application: $app_name"
  sudo apt install -y "$app_name"
  if [ $? -eq 0 ]; then
    echo "Successfully installed application: $app_name"
  else
    echo "Failed to install application: $app_name"
  fi
done

echo "Application installation complete."