# Use a minimal Ubuntu base image
FROM ubuntu:20.04

# Update package lists and install necessary packages
RUN apt-get update && \
    apt-get install -y openssh-server sudo && \
    apt-get clean

# Create a directory for the SSH daemon
RUN mkdir /var/run/sshd

# Set a password for the root user (for demonstration purposes)
RUN echo 'root:ritchieRootVerySecured#1!' | chpasswd

# Allow root login via SSH
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Change the SSH port to 2222
RUN sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config

# SSH login fix. Otherwise, user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Create the Desktop directory for root user
RUN mkdir -p /home/root/Desktop

# Create a flag file in root's Desktop and set the correct permissions
#this ensure that only the root can read this flag
RUN echo 'EYF{make_sure_Y0u_Also_$ecure_r00t}' > /home/root/Desktop/flag.txt && \
    chown root:root /home/root/Desktop/flag.txt && \
    chmod 400 /home/root/Desktop/flag.txt


# Add user ritchie and set password
RUN useradd -m -s /bin/bash ritchie && echo 'ritchie:password' | chpasswd

# Add ritchie to sudoers
RUN usermod -aG sudo ritchie

# Create the Desktop directory for ritchie user
RUN mkdir -p /home/ritchie/Desktop && chown -R ritchie:ritchie /home/ritchie/Desktop

# Create a flag on ritchie's desktop
RUN echo 'EYF{n3v3r_use_c0mm0n_p@sswords}' > /home/ritchie/Desktop/flag.txt && \
    chown ritchie:ritchie /home/ritchie/Desktop/flag.txt


# Start the SSH service
CMD ["/usr/sbin/sshd", "-D"]
