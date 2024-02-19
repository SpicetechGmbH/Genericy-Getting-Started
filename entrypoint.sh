#!/bin/bash

echo "Running the upgrade script to ensure the latest application version..."
# Run the upgrade script to download the latest application version
/genericy/upgrade.sh

echo "Starting the cron service..."
# Start the cron service
cron -f

echo "Container is running. Waiting for termination signal..."

# Create a simple infinite loop to keep the container running
while true; do
    sleep 60
done
