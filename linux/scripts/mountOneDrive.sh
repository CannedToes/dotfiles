#!/bin/bash

# Variables
remoteName=OneDrive

echo "Spawning mount for $remoteName"

# actually mount the drive
rclone mount OneDrive: /home/myles/OneDrive/ --vfs-cache-mode full
