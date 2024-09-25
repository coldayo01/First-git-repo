#!/bin/bash
# Function to check if a package is installed
check_and_install() {
    PACKAGE_NAME=$1
    if dpkg -l | grep -q "$PACKAGE_NAME"; then
        echo "$PACKAGE_NAME is already installed."
    else
        echo "$PACKAGE_NAME is not installed. Installing..."
        sudo apt-get update -y
        sudo apt-get install -y "$PACKAGE_NAME"
        if [ $? -eq 0 ]; then
            echo "$PACKAGE_NAME installation completed."
        else
            echo "Failed to install $PACKAGE_NAME."
        fi
    fi
}

# Check if the user passed any arguments
if [ $# -eq 0 ]; then
    echo "No package name provided. Usage: ./script.sh <package_name1> <package_name2> ..."
    exit 1
fi

# Loop over all the arguments provided and check each one
for package in "$@"
do
    check_and_install "$package"
done