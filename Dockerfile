FROM debian:10.1

RUN useradd -ms /bin/bash buildmaster

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    gawk wget git-core diffstat unzip texinfo gcc-multilib \
    build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
    xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
    pylint3 xterm \
    autotools-dev \
    bash \
    locales \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
RUN locale-gen
ENV LANG='en_US.UTF-8' LANGUAGE='en_US.UTF-8' LC_ALL='en_US.UTF-8'

USER buildmaster

RUN mkdir -p /home/buildmaster/yocto
RUN chown buildmaster:buildmaster /home/buildmaster/yocto

WORKDIR /home/buildmaster

WORKDIR /home/buildmaster/yocto
RUN git clone git://git.yoctoproject.org/poky 
RUN cd /home/buildmaster/yocto/poky && \
    git checkout -b zeus origin/zeus
