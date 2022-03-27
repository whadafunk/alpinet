# Basic network enabled container
# Installed Tools:
# - openssh-server
# - ssh client
# - nmap
# - tcpdump
# - netcat
# - iproute2
# - net-tools
# - mc
# - vim
# - tmux

FROM alpine:latest
MAINTAINER gri.daniel@gmail.com
# Instead of using MAINTAINER, we can use LABEL which is more flexible
LABEL my_name="Daniel Grigore"
LABEL my_site="Routerology"
LABEL my_quote="The quick brown fox"

RUN adduser --disabled-password -g admin -h /home/admin -s /bin/sh admin
# Setting password for this would be the next question
RUN echo "admin:pass123" | chpasswd

RUN apk update
RUN apk	add openssh-server
RUN apk add openssh
RUN apk add nmap
RUN apk add tcpdump
# We do not need to add netcat as we already have this in busybox
# Busybox hase some iproute2 stuff but is not very good
RUN apk add iproute2
RUN apk add tmux
RUN apk add mc

# Create the keys for sshd server
RUN /usr/bin/ssh-keygen -t rsa -b 4096 -q -N '' -f /etc/ssh/ssh_host_rsa_key
RUN /usr/bin/ssh-keygen -t dsa -b 1024 -q -N '' -f /etc/ssh/ssh_host_dsa_key
RUN /usr/bin/ssh-keygen -t ecdsa -b 521 -q -N '' -f /etc/ssh/ssh_host_ecdsa_key
RUN /usr/bin/ssh-keygen -t ed25519 -b 4096 -q -N '' -f /etc/ssh/ssh_host_ed25519_key

# Change permissions on the ssh server keys
RUN chmod 600 /etc/ssh/ssh_host_*_key

# Bring over our ssh config files (both server and client)
COPY ./ssh/ /etc/ssh/

# We do not need this so much, but for exemplification purpose
# We will anounce that our container listens on sshd port
EXPOSE 22/tcp

# This is how we add our persistent storage
# The persistent storage is not deleted with the container

VOLUME /storage
WORKDIR /root

# Setting our shell prompt through ENV variables

ENV PS1="\h \w> "


#CMD ["/bin/sh"]
CMD ["/usr/sbin/sshd","-D","-4","-q","-p 22"]
