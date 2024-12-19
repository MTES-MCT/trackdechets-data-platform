#!/bin/bash

# Load configuration
CONFIG_FILE="/opt/trackdechets-data-platform/ssh_tunnels.conf"

if [ ! -f $CONFIG_FILE ]; then
    echo "Configuration file $CONFIG_FILE not found. Exiting."
    exit 1
fi

source $CONFIG_FILE

# Check if a specific tunnel is up
check_tunnel() {
    local local_port=$(echo $1 | cut -d':' -f2)
    nc -z localhost $local_port
    return $?
}

# Create a tunnel
create_tunnel() {
    local tunnel=$1
    local local_port=$(echo $tunnel | cut -d':' -f2)
    local remote_host=$(echo $tunnel | cut -d':' -f3-)
    ssh -L $tunnel -i $KEY_PATH $SSH_USER -NTf
}

# Check and recreate tunnels if needed
monitor_tunnels() {
    if ! check_tunnel $TUNNEL1; then
        echo "$(date): Tunnel 1 is down. Re-establishing..."
        create_tunnel $TUNNEL1
    else
        echo "$(date): Tunnel 1 is running."
    fi

    if ! check_tunnel $TUNNEL2; then
        echo "$(date): Tunnel 2 is down. Re-establishing..."
        create_tunnel $TUNNEL2
    else
        echo "$(date): Tunnel 2 is running."
    fi
}

# Main function
while true; do
    monitor_tunnels
    sleep 60  # Check every 60 seconds
done