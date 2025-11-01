# Ubuntu Environment Setup with Ansible

This repository contains a set of scripts to automate the setup and configuration of a development environment on Ubuntu Linux (inclding WSL) using Ansible.

The goal is to create a consistent, repeatable, and version-controlled process for bootstrapping a machine with essential development tools.

## Features

The Ansible playbook will install and configure the following software:

-   **Base Packages**: `curl`, `git`, `python3-pip`, and other essentials.
-   **Python**: Ensures the latest version of `python3` is installed.
-   **Docker**: Installs the latest Docker Engine, CLI, and Docker Compose. It also adds the current user to the `docker` group to allow running Docker commands without `sudo`.
-   **NVM (Node Version Manager)**: Installs NVM to manage multiple Node.js versions.
-   **Node.js**: Installs the latest stable version of Node.js using NVM.
-   **Git (latest)**: Ensures Git is installed and up to date.
-   **GitHub CLI (gh)**: Adds the official GitHub CLI apt repo and installs `gh`.
-   **AWS CLI v2**: Installs the official AWS CLI v2 via Amazon's bundled installer (architecture-aware).
-   **kubectl**: Adds the Kubernetes apt repo and installs the `kubectl` client.
-   **Terraform**: Adds the HashiCorp apt repo and installs `terraform`.

## Prerequisites

-   An Ubuntu-based system (e.g., Ubuntu 22.04 on WSL).
-   A user account with `sudo` privileges.

## Quick Start (Local WSL/Ubuntu Setup)

Follow these steps to configure your local machine.

1.  **Clone the repository:**
    ```bash
    git clone <your-repository-url>
    cd ansible-setup
    ```

2.  **Make the setup script executable:**
    ```bash
    chmod +x setup.sh
    ```

3.  **Run the script:**
    ```bash
    ./setup.sh
    ```

The script will first check if Ansible is installed. If not, it will prompt you for permission to install it. Afterwards, it will run the Ansible playbook and ask for your `sudo` password to perform the installation tasks.

4.  **Refresh your shell:**
    After the script completes, you must refresh your shell session to use `nvm` and `node`.
    ```bash
    source ~/.bashrc
    ```
    Alternatively, you can simply open a new terminal window.

## Deploying to Remote Ubuntu Hosts

You can use the same playbook to configure other Ubuntu servers on your network.

1.  **Add Hosts to Inventory**:
    Open the `inventory.ini` file and add the IP addresses or hostnames of your remote servers under the `[remote_ubuntu]` group.

2.  **Ensure SSH Access**:
    Make sure you have SSH access from your local machine to the remote hosts. Using SSH key-based authentication is highly recommended.

3.  **Run Ansible**:
    Execute the playbook, targeting the `remote_ubuntu` group.
    ```bash
    ansible-playbook -i inventory.ini playbook.yml --ask-become-pass -l remote_ubuntu
    ```

## File Breakdown

-   `setup.sh`: The entry-point script that checks for Ansible and runs the playbook locally.
-   `playbook.yml`: The core Ansible playbook containing all the roles and tasks for setting up the software.
-   `inventory.ini`: The Ansible inventory file where you define the hosts to be managed.
