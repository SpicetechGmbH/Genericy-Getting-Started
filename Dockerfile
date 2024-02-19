FROM eclipse-temurin:17-jre-jammy

# Install required packages
RUN apt-get update && apt-get install -y cron curl tini

# Prepare working directory
WORKDIR /genericy

# Copy necessary scripts and files into the image
COPY entrypoint.sh upgrade.sh /genericy/
COPY genericy-crontab /etc/cron.d/genericy-crontab
COPY application.properties /genericy/

# Set permissions and owner for cron files
RUN chmod +x /genericy/entrypoint.sh /genericy/upgrade.sh && \
    chmod 0644 /etc/cron.d/genericy-crontab && \
    chown root:root /etc/cron.d/genericy-crontab && \
    touch /var/log/cron.log && \
    chown root:root /var/log/cron.log

# Use tini as ENTRYPOINT
ENTRYPOINT ["/usr/bin/tini", "--", "/genericy/entrypoint.sh"]

# Define an anonymous volume
VOLUME /genericy
