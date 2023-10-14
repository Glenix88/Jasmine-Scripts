#! /bin/bash

# Define new network settings
NEW_IP="192.168.1.100/24"
NEW_GATEWAY="192.168.1.1"
NEW_DNS1="8.8.8.8"
NEW_DNS2="8.8.4.4"

# The Netplan configuration file path
NETPLAN_CONFIG="/etc/netplan/01-netcfg.yaml"

# Validate that the Netplan file exists
if [ ! -f "$NETPLAN_CONFIG" ]; then
    echo "Netplan config not found!"
    exit 1
fi

# Change the IP address
sed -i "s/\(addresses:\).*\$/\1 [$NEW_IP]/" $NETPLAN_CONFIG

# Change the Gateway
sed -i "s/\(gateway4:\).*\$/\1 $NEW_GATEWAY/" $NETPLAN_CONFIG

# Change the DNS
sed -i "s/\(nameservers:\)/\1\n          addresses: [$NEW_DNS1, $NEW_DNS2]/" $NETPLAN_CONFIG

# Apply the new Netplan settings
netplan apply

# Check if it is applied successfully
if [ $? -eq 0 ]; then
  echo "Network settings have been updated successfully."
else
  echo "Failed to apply new network settings."
fi
