FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install SSH, Python, sudo, curl, and sysvinit-utils to act as our stable init manager
RUN apt-get update && apt-get install -y \
    nginx \
    openssh-server \
    rsync \
    python3 \
    sudo \
    curl \
    sysvinit-utils \
    && rm -rf /var/lib/apt/lists/*

# Fix SSH service configurations and generate missing host keys
RUN mkdir /var/run/sshd
RUN ssh-keygen -A

# Ensure root login via keys is completely allowed by the daemon
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Setup SSH keys
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh
COPY test_key_1.pub /root/.ssh
RUN cat /root/.ssh/test_key_1.pub > /root/.ssh/authorized_keys && chmod 600 /root/.ssh/authorized_keys

# Copy the static site files to the Nginx web server directory
RUN chmod -R 755 /var/www/html
COPY ./simple-static-site /var/www/html

# Copy the statup script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose ports for SSH (22) and Nginx (80)
EXPOSE 22 80

# Start SSH daemon and use init tail to keep the container permanently running smoothly
ENTRYPOINT ["/entrypoint.sh"]
