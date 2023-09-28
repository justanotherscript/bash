#!/bin/bash

# Ensure the script is being run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root." 1>&2
    exit 1
fi

# Check if unattended-upgrades is enabled already
if grep -qr '^APT::Periodic::Unattended-Upgrade "1"' /etc/apt/apt.conf.d/; then
    echo "Unattended-upgrades are already enabled!"
    exit 0
fi

# Install the required package
apt update
apt install -y unattended-upgrades

# Enable automatic security updates
echo 'APT::Periodic::Update-Package-Lists "1";' > /etc/apt/apt.conf.d/10periodic
echo 'APT::Periodic::Download-Upgradeable-Packages "1";' >> /etc/apt/apt.conf.d/10periodic
echo 'APT::Periodic::AutocleanInterval "7";' >> /etc/apt/apt.conf.d/10periodic
echo 'APT::Periodic::Unattended-Upgrade "1";' >> /etc/apt/apt.conf.d/10periodic

# Configure the packages that should be upgraded
echo 'Unattended-Upgrade::Allowed-Origins {' > /etc/apt/apt.conf.d/50unattended-upgrades
echo '  "${distro_id}:${distro_codename}-security";' >> /etc/apt/apt.conf.d/50unattended-upgrades
echo '//  "${distro_id}:${distro_codename}-updates";' >> /etc/apt/apt.conf.d/50unattended-upgrades
echo '//  "${distro_id}:${distro_codename}-proposed";' >> /etc/apt/apt.conf.d/50unattended-upgrades
echo '//  "${distro_id}:${distro_codename}-backports";' >> /etc/apt/apt.conf.d/50unattended-upgrades
echo '};' >> /etc/apt/apt.conf.d/50unattended-upgrades

# Optional: Remove any unused dependencies
apt --purge autoremove

echo "Automatic security updates have been enabled!"
