# References
# https://dev.to/s1ntaxe770r/how-to-setup-ssh-within-a-docker-container-i5i
# https://github.com/rastasheep/ubuntu-sshd
# https://github.com/linuxserver/docker-openssh-server
# https://github.com/chusiang/ansible-managed-node.dockerfile
FROM ubuntu:20.04 

# If not assigned, tzdata, one of the openssh-server's dependencies,
# will prompt to ask the default timezone and block the installation
RUN ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime

# Install openssh-server and Ansible
RUN apt-get update \
  && apt-get install -y \
    software-properties-common openssh-server \
  && add-apt-repository --yes --update ppa:ansible/ansible \
  && apt-get install -y ansible \
  && rm -rf /var/lib/apt/lists/*

# Modify sshd's default config to allow login with root account
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN service ssh start

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]
