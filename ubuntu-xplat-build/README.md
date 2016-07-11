# ubuntu-xplat-build
Dockerfile to compose upon the ubuntu-minjava-build image to build an Ubuntu docker container to run the Team Services coreCLR build agent for building
cross-platform (xplat) software.  Tools and languages available include:
* Java (OpenJDK 7 and 8)
* Ant, Maven and Gradle
* C and C++
* .NET
* NodeJS
* Gulp
* Ruby and Rails
* Go
* Python
* Perl


This Docker Image is dependent on ubuntu-minjava-build so you must first download and build that image first.
See https://github.com/Microsoft/vsts-dockerfiles/blob/master/ubuntu-minjava-build/README.md


Example of how to build on an Ubuntu Docker host:

 cd vsts-dockerfiles/ubuntu-xplat-build

 sudo docker build --tag javaalm/vsts-ubuild-full .



Example of how to run a container once the image above is built:

 docker run -d --privileged --name <Docker container name> javaalm/vsts-ubuild-full ./vsts-startup.sh <Team Services Account url> <PAT> <Pool Name> <Agent Name> 



so something like this (but using your Team Services Account, PAT, and Pool and Agent names):

 docker run -d --privileged --name docker-xplat-full javaalm/vsts-ubuild-full ./vsts-startup.sh https://myaccount.visualstudio.com/ spqnoh4j2sqklayog3ipsjovc3z5njvthpm2o4jdrdre2ztqxxxx default docker-xplat-full

