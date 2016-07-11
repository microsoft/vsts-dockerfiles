# Build a Team Services coreCLR Ubunut xplat build machine

FROM javaalm/vsts-ubuild-minjava

MAINTAINER Paul T. Barham <pabarham@microsoft.com>

LABEL version="RC2"
LABEL description="An Ubuntu 16 VM with cross-platform developer tools and Team Services coreCLR build agent"

USER root

RUN apt-get update && \
    apt-get -y install build-essential && \
# Next three lines needed only for Ruby and Rails
    apt-get -y install git-core curl zlib1g-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev && \
    apt-get -y install sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev && \
    apt-get -y install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev && \
# Install popular cross-platform dev packages
    apt-get -y install packaging-dev && \
    apt-get -y update && \
    apt-get -y install gradle && \
    curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - && \
    apt-get -y install nodejs && \
    npm install -g gulp && \
    apt install -y golang-go
   
WORKDIR /home/xplatalm 

# Download .NET libs/tools
ADD https://dotnetcli.blob.core.windows.net/dotnet/preview/Binaries/1.0.0-preview2-002875/dotnet-dev-ubuntu-x64.1.0.0-preview2-002875.tar.gz downloads/
RUN chmod 0666 -R downloads/* && chown xplatalm:xplatalm downloads

# Install Ruby and Rails
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
    curl -sSL https://get.rvm.io | bash -s stable --rails
RUN /bin/bash -c "source /usr/local/rvm/scripts/rvm"
RUN /bin/bash -c "source /etc/profile.d/rvm.sh"
ENV PATH $PATH:/usr/local/rvm/bin:/usr/local/rvm/rubies/ruby-2.3.1/bin:/usr/local/rvm/gems/ruby-2.3.1/bin
RUN rvm install 2.3.1
RUN gem install rails
RUN gem install bundler
RUN rails -v

USER xplatalm

# Set Ruby/Rails paths 
ENV PATH $PATH:/usr/local/rvm/bin:/usr/local/rvm/rubies/ruby-2.3.1/bin:/usr/local/rvm/gems/ruby-2.3.1/bin

# Install gulp locallally with flag and run gradle once to get them setup
WORKDIR /home/xplatalm
RUN npm install gulp --save-dev
RUN /usr/bin/gradle

# Install .NET libraries/tools
RUN mkdir lib && \
    mkdir lib/dotnet
WORKDIR /home/xplatalm/lib/dotnet
RUN tar xvfz /home/xplatalm/downloads/dotnet-dev-ubuntu-x64.1.0.0-preview2-002875.tar.gz
ENV PATH $PATH:/home/xplatalm/lib/dotnet

USER root
# Best practice to clean up some files to make Docker image smaller
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /home/xplatalm/downloads

# Leave image/container as xplatalm in the VSTS agent directory
USER xplatalm
WORKDIR /home/xplatalm/vsts-agent/
