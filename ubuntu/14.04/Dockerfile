# A docker image that contains helpful development tools (compilers, editors, network utilities)
FROM ubuntu:14.04

MAINTAINER Nathan Toone "nathan@toonetown.com"

RUN apt-get update \
 && apt-get install -yq apt-utils \
                        git \
                        gcc \
                        g++ \
                        make \
                        automake \
                        autoconf \
                        libtool \
                        pkg-config \
                        gettext \
                        perl \
                        python \
                        flex \
                        bison \
                        net-tools \
                        iputils-ping \
                        iptables \
                        vim \
 && DEBIAN_FRONTEND=noninteractive apt-get install -yq tshark \
 && rm -rf /var/lib/apt/lists/*

# Add the docker_pipe command (which is super helpful)
ADD https://gist.githubusercontent.com/toonetown/cbb006b81e3e54eccbec301af9dbf7bf/raw   /usr/local/bin/docker_pipe
RUN chmod 755 /usr/local/bin/docker_pipe

CMD [ "/bin/bash" ]
