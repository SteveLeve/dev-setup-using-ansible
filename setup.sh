#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Check for Ansible ---
if ! command -v ansible &> /dev/null; then
    echo "Ansible is not installed."
    read -p "Would you like to install Ansible now? (y/n) " -n 1 -r
    echo # Move to a new line

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Installing Ansible..."
        # Add Ansible PPA and install
        sudo apt update
        sudo apt install -y software-properties-common
        sudo add-apt-repository --yes --update ppa:ansible/ansible
        sudo apt install -y ansible
        echo "Ansible installation complete."
    else
        echo "Ansible is required to proceed. Exiting."
        exit 1
    fi
fi

# --- Run Ansible Playbook ---
echo "Ansible is ready. Running the playbook to configure the environment..."
# --ask-become-pass will prompt for your sudo password
# -l local limits the playbook run to the 'local' group in your inventory
ansible-playbook -i inventory.ini playbook.yml --ask-become-pass -l local

echo "✅ environment setup is complete!"
echo "   Run 'source ~/.bashrc' or open a new terminal to use nvm and node."
