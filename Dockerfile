FROM ubuntu:18.04

ARG USE_APT_MIRROR=no
ARG USE_MYSQL=no

ENV DEBIAN_FRONTEND noninteractive

RUN (test ${USE_APT_MIRROR} = yes \
       && \
       (sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list) \
       || \
       (echo "APT mirror config untouched.");) \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apt-get update \
    && apt-get install -y tzdata \
    && dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get install -y git g++ python build-essential \
    checkinstall libreadline-gplv2-dev libncursesw5-dev \
    libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev \
    libbz2-dev scons swig m4 autoconf automake libtool curl \
    make g++ unzip python-pydot flex bison xutils libx11-dev \
    libxt-dev libxmu-dev libxi-dev libgl1-mesa-dev python-dev \
    imagemagick libpng-dev cmake \
    && pip2 install mako

ENTRYPOINT [ "bin/bash" ]