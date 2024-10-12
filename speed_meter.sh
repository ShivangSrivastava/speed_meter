#!/bin/bash

# Define the network interface (replace `wlp2s0` with your active interface)
interface="wlp2s0"

# Get initial data
rx1=$(cat /proc/net/dev | grep $interface | awk '{print $2}')
tx1=$(cat /proc/net/dev | grep $interface | awk '{print $10}')

# Wait for 1 second
sleep 1

# Get data after 1 second
rx2=$(cat /proc/net/dev | grep $interface | awk '{print $2}')
tx2=$(cat /proc/net/dev | grep $interface | awk '{print $10}')

# Calculate download and upload speed (in bytes per second)
rx_speed=$((rx2 - rx1))
tx_speed=$((tx2 - tx1))

# Function to format the speed output
format_speed() {
    local speed=$1
    if [ $speed -lt 1024 ]; then
        echo "$speed Bps"
    elif [ $speed -lt $((1024 * 1024)) ]; then
        speed_kb=$(echo "scale=2; $speed/1024" | bc)
        echo "$speed_kb KBps"
    else
        speed_mb=$(echo "scale=2; $speed/(1024*1024)" | bc)
        echo "$speed_mb MBps"
    fi
}

# Output the result with formatted speed
echo "$(format_speed $rx_speed) ⬇ / $(format_speed $tx_speed) ⬆"
