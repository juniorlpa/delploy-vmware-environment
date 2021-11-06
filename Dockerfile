FROM ubuntu:20.04

WORKDIR /ansible

# Labels.
LABEL maintainer="Luiz Andrade"                          \
    org.label-schema.description="Ansible inside Docker" \
    org.label-schema.docker.cmd="" 

# install the dependecies
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone
RUN apt-get update &&                                             \
    apt-get install -y                                            \
    openssh-client                                                \
    python3-pip                                                   \
    python3-pyvmomi                                               \
    software-properties-common

# Ansible installation
RUN add-apt-repository --yes --update ppa:ansible/ansible-2.10 && \
    apt-get install -y ansible &&                                 \
    rm -rf /var/lib/apt/lists/* &&                                \
    apt-get clean
    
CMD ["/bin/bash/ansible --version"]