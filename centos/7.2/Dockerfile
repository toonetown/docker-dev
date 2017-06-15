# A docker image that contains helpful development tools (compilers, editors, network utilities)
FROM centos:7.2.1511

MAINTAINER Nathan Toone "nathan@toonetown.com"

RUN yum install -y -q git \
                      gcc \
                      gcc-c++ \
                      make \
                      automake \
                      autoconf \
                      libtool \
                      pkgconfig \
                      gettext \
                      perl \
                      python \
                      flex \
                      bison \
                      net-tools \
                      iptables \
                      wireshark \
                      vim \
 && yum clean all

# Add the docker_pipe command (which is super helpful)
ADD https://gist.githubusercontent.com/toonetown/cbb006b81e3e54eccbec301af9dbf7bf/raw   /usr/local/bin/docker_pipe
RUN chmod 755 /usr/local/bin/docker_pipe

CMD [ "/bin/bash" ]
