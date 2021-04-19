FROM ubuntu:latest

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y build-essential nasm sudo wget curl
RUN /bin/bash -c "echo \"PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '\" >> /root/.bashrc "

VOLUME /root/env
WORKDIR /root/env