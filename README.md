# NETWORK TOOLS CONTAINER

## A small toolset client based on Alpine Linux

*I have added a couple of networking tools and sshd to the standard alpine image and that's that what this container is all about*

## Tools

- iproute2
- openssh server
- openssh client
- tcpdump
- nmap
- netcat
- net-tools
- vim
- tmux
- mc

## Instructions

*The container is starting the sshd process and uses the config files from this directory*
*You can login with user admin / pass123, and you will also have sudo

> docker container run -d --rm --name alpinet --hostname alpinet routerology/alpinet:latest

To authenticate to ssh you can use the following credentials:

admin / pass123
