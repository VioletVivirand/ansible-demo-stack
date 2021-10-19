# ansible-demo-stack
A Docker Compose stack for test with Ansible, Ubuntu, and sshd installed

## Build Docker image

```bash
$ docker build --no-cache -t ansible-ubuntu-sshd:latest .
```

Or download directly from GitHub Packages Container registry:

```bash
$ docker pull ghcr.io/violetvivirand/ansible-ubuntu-sshd:latest
```

## Generate SSH key pairs

```bash
$ mkdir ./.ssh
$ ssk-keygen ssh-keygen -t rsa -b 4096 -C "" -f ./.ssh/id_rsa
$ cat ./.ssh/id_rsa.pub >> ./.ssh/authorized_keys
```

## Start the stacks

```bash
$ docker-compose up -d
```

This will run 3 containers by default, **1 control node** and **2 managed nodes**.

## Add every nodes into known hosts list

Execute:

```bash
$ docker-compose exec control \
  bash -c 'HOSTS="control managed1 managed2"; for host in $HOSTS; do ssh-keyscan $host >> /root/.ssh/known_hosts; done'
```

If you have more nodes, add them into the `HOSTS` variable.

## Enter the control node container and test

```bash
$ docker-compose exec control bash
$ ssh managed
```
