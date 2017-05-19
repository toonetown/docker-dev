# A docker image that contains helpful development tools (compilers, editors, network utilities)
FROM alpine:latest

MAINTAINER Nathan Toone "nathan@toonetown.com"

RUN apk add --no-cache bash \
                       git \
                       gcc \
                       g++ \
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
                       tshark \
                       vim

# Add the docker_pipe command (which is super helpful)
ADD https://gist.githubusercontent.com/toonetown/cbb006b81e3e54eccbec301af9dbf7bf/raw   /usr/local/bin/docker_pipe
RUN chmod 755 /usr/local/bin/docker_pipe

CMD [ "/bin/bash" ]
