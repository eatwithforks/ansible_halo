#!/bin/bash

#   CloudPassage Halo Daemon
#   Unattended installation script for qa-automation-pro100
#   -------------------------------------------------------------------------
#   This script is intended to be used for an unattended installation
#   of the CloudPassage Halo daemon.
#
#   IMPORTANT NOTES
#
#     * This script may require adjustment to conform to your server's
#       configuration. Please review this script and test it on a server
#       before using it to install the Halo daemon on multiple servers.
#
#     * This script contains the CloudPassage Halo Daemon Registration Key owned by
#       qa-automation-pro100. Keep this script safe - handle it as
#       you would the password to your CloudPassage portal account!
#
#     * This is a customized script that keeps the Halo Agent service permanently running
#
#     * Must run this script as a root user
#
#     * Rhel 7+, Centos 7

# Create cphalod.service override directory
sudo mkdir -p /etc/systemd/system/cphalod.service.d/

# Create cphalod service override parameters
sudo cat <<EOT > /etc/systemd/system/cphalod.service.d/override.conf
[Unit]
OnFailure=failover.service
[Service]
Restart=always
ExecStop=/bin/echo "CloudPassage Halo Agent is stopped...spinning up lifeboat"
ExecStopPost=/bin/systemctl status cphalod
EOT

Create cphalod failover service
sudo cat <<EOT > /etc/systemd/system/failover.service
[Unit]
Description=failover handler
OnFailure=cphalod.service
[Service]
Type=forking
Restart=always
ExecStart=/etc/rc.d/init.d/cphalod start
ExecStopPost=/bin/systemctl status failover
EOT

# Reload cphalod service systemd settings
sudo systemctl daemon-reload

# Set cphalod to run on boot up
sudo systemctl enable cphalod.service

# Start the daemon for the first time
sudo systemctl start cphalod
