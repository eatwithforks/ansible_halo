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
#     * Ubuntu 9.10 to Ubuntu 14.10, including Ubuntu 14.04

# Create Upstart Persistent Job File
sudo cat <<EOT > /etc/init/cphalod.conf
description "A job file that keeps cphalod running persistently"
author "CloudPassage Integration"

start on runlevel [2345]
stop on runlevel [016]

respawn

exec start-stop-daemon --start --name cphalod --exec /opt/cloudpassage/bin/cphalo --pidfile=/opt/cloudpassage/data/halo.pid

pre-stop script
        start
end script
EOT

# start the daemon for the first time
sudo /etc/init.d/cphalod start