#!/bin/bash

# URLs
VERSION_URL="https://github.com/SpicetechGmbH/Genericy-Getting-Started/raw/main/version.txt"
UPGRADE_URL="https://github.com/SpicetechGmbH/Genericy-Getting-Started/raw/main/genericy.jar"

# Local version file and JAR
LOCAL_VERSION_FILE="/genericy/version.txt"
CURRENT_JAR="/genericy/genericy.jar"

echo "Checking for updates..."

# Download the latest version number and save it temporarily
curl -L -s -o /tmp/latest_version.txt $VERSION_URL || { echo "Error downloading the version file."; exit 1; }

# Read local and latest version numbers
LATEST_VERSION=$(cat /tmp/latest_version.txt)
LOCAL_VERSION=$(cat $LOCAL_VERSION_FILE 2>/dev/null || echo "0")

# Compare the version numbers
if [ "$LATEST_VERSION" \> "$LOCAL_VERSION" ]; then
    echo "New version found: $LATEST_VERSION. Updating from version $LOCAL_VERSION."

    # Perform the update
    if curl -L -o $CURRENT_JAR $UPGRADE_URL; then
        echo "Update successfully downloaded. Updating the application."

        # Find the running Java process and send SIGTERM if it exists
        JAVA_PID=$(pgrep -f 'java -jar /genericy/genericy.jar')
        if [ ! -z "$JAVA_PID" ]; then
            echo "Terminating the running Java process: PID=$JAVA_PID"
            kill -SIGTERM $JAVA_PID
            # Wait for the process to terminate
            wait $JAVA_PID
        else
            echo "No running Java process found. No termination necessary."
        fi

        # Update the local version file
        echo $LATEST_VERSION > $LOCAL_VERSION_FILE

        # (Optional) Restart the Java process, depending on your application logic
        echo "Restarting the application..."
        java -jar $CURRENT_JAR &
    else
        echo "Error downloading the update."
    fi
else
    echo "No update necessary. Current version is $LOCAL_VERSION."
fi
