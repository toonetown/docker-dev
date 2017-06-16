#!/bin/bash
# Environment variables for alpine linux

: ${DFILE_BASE:="alpine"}
: ${DFILE_VERS:="latest"}
: ${DFILE_INST:="apk add --no-cache"}
: ${DFILE_PKGS:="bash \
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
                 vim"}
: ${DFILE_CLEAN:=""}
