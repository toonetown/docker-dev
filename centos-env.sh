#!/bin/bash
# Environment variables for centos linux

: ${DFILE_BASE:="centos"}
: ${DFILE_VERS:="latest"}
: ${DFILE_INST:="yum install -y -q"}
: ${DFILE_PKGS:="git \
                 gcc \
                 gcc-c++ \
                 make \
                 automake \
                 autoconf \
                 libtool \
                 gettext \
                 perl \
                 flex \
                 bison \
                 net-tools \
                 iptables \
                 wireshark \
                 vim"}
: ${DFILE_CLEAN:="&& yum clean all"}
