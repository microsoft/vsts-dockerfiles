# Build a Team Services coreCLR Ubunut xplat build machine

FROM ubuntu:16.04

LABEL maintainer="Paul T. Barham <pabarham@microsoft.com>"

LABEL version="RC2"
LABEL description="An Ubuntu 16 VM with Java developer tools and Team Services coreCLR build agent"

ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux
ENV JAVA_TOOL_OPTIONS -Dfile.encoding=UTF8
ENV _system_type Linux
ENV _system_name Ubuntu
ENV _system_version 16.04


RUN apt-get update && \ 
    apt-get upgrade -y && \
    apt-get install -y dialog && \
    apt-get install -y sudo && \
    apt-get install -y wget && \
    apt-get -y install software-properties-common && \
    apt-get -y install python-software-properties && \
    apt-get -y install vim && \
    apt-get -y install inetutils-ping && \
    apt-get -y install ftp

RUN apt-get update && \
    add-apt-repository -y ppa:openjdk-r/ppa && \
    apt-get -y update && \
    apt-get -y install openjdk-7-jdk && \
    apt-get -y update --fix-missing && \
    apt-get -y install openjdk-7-jdk && \
    apt-get install -y openjdk-8-jdk && \
    apt-get -y update --fix-missing && \
    apt-get -y install  openjdk-8-jdk && \
    ln -s /usr/lib/jvm/java-8-openjdk-amd64/ /usr/lib/jvm/default-java && \
    apt-get -y install ant maven && \
    apt-get -y install libunwind8 libcurl3

RUN adduser --quiet xplatalm
WORKDIR /home/xplatalm
ENV USER xplatalm
ENV SHELL /bin/bash
ENV LOGNAME xplatalm

# Download required security patch, .NET libs/tools, and VSTS agent
ADD http://security.ubuntu.com/ubuntu/pool/main/i/icu/libicu52_52.1-8ubuntu0.2_amd64.deb downloads/
RUN dpkg -i downloads/libicu52_52.1-8ubuntu0.2_amd64.deb
ADD https://github.com/Microsoft/vsts-agent/releases/download/v2.102.1/vsts-agent-ubuntu.14.04-x64-2.102.1.tar.gz downloads/
RUN chmod 0666 -R downloads/* && chown xplatalm:xplatalm downloads

USER xplatalm

# Install VSTS Agent
WORKDIR /home/xplatalm
RUN mkdir /home/xplatalm/vsts-agent
WORKDIR /home/xplatalm/vsts-agent
RUN tar xvzf /home/xplatalm/downloads/vsts-agent-ubuntu*

# Setup Environment variables needed
ENV LANG en_US.UTF-8
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV JAVA_HOME_7_X64 /usr/lib/jvm/java-7-openjdk-amd64
ENV JAVA_HOME_8_X64 /usr/lib/jvm/java-8-openjdk-amd64

RUN echo "LANG=en_US.UTF-8" > .env && \
    echo "export LANG=en_US.UTF-8" >> /home/xplatalm/.bashrc && \
    export LANG=en_US.UTF-8 && \
    echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> .env && \
    echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /home/xplatalm/.bashrc && \
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 && \
    export JAVA_HOME_7_X64=/usr/lib/jvm/java-7-openjdk-amd64 && \
    echo "JAVA_HOME_7_X64=/usr/lib/jvm/java-7-openjdk-amd64" >> .env && \
    echo "export JAVA_HOME_7_X64=/usr/lib/jvm/java-7-openjdk-amd64" >> /home/xplatalm/.bashrc && \
    echo "JAVA_HOME_8_X64=/usr/lib/jvm/java-8-openjdk-amd64" >> .env && \
    echo "export JAVA_HOME_8_X64=/usr/lib/jvm/java-8-openjdk-amd64" >> /home/xplatalm/.bashrc && \
    export JAVA_HOME_8_X64=/usr/lib/jvm/java-8-openjdk-amd64 && \
    echo $PATH > /home/xplatalm/vsts-agent/.path && \
    echo "export PATH=$PATH:"$PATH >> /home/xplatalm/.bashrc && \
    sed -i 's,NODE_ENV=production,,g' ./bin/vsts.agent.service.template

# Install VSTS start-up script
COPY vsts-startup.sh /home/xplatalm/vsts-agent/
USER root
RUN chmod 0755 vsts-startup.sh && chown xplatalm:xplatalm vsts-startup.sh

# Best practice to clean up some files to make Docker image smaller
RUN rm -rf /home/xplatalm/downloads
RUN rm -rf /var/lib/apt/lists/*

# Leave image/container as xplatalm in the VSTS agent directory
USER xplatalm
WORKDIR /home/xplatalm/vsts-agent/

RUN echo "export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8" >> /home/xplatalm/.bashrc && \
    echo "export LOGNAME=xplatalm" >> /home/xplatalm/.bashrc && \
    echo "export _system_name=Ubuntu" >> /home/xplatalm/.bashrc && \
    echo "export USER=xplatalm" >> /home/xplatalm/.bashrc && \
    echo "export _system_version=16.04" >> /home/xplatalm/.bashrc && \
    echo "export SHELL=/bin/bash" >> /home/xplatalm/.bashrc && \
    echo "export _system_type=Linux" >> /home/xplatalm/.bashrc

RUN /bin/bash -c "source /home/xplatalm/.bashrc"
