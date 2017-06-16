#!/bin/bash
# Environment variables for centos linux

: ${DFILE_BASE:="ubuntu"}
: ${DFILE_VERS:="latest"}
: ${DFILE_INST:="apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq"}
: ${DFILE_PKGS:="apt-utils \
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
                 tshark \
                 vim"}
: ${DFILE_CLEAN:="&& rm -rf /var/lib/apt/lists/*"}
