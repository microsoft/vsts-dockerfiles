# ubuntu-minjava-build
Dockerfile and shell script to build an Ubuntu docker container to run the Team Services coreCLR build agent for building
Java (OpenJDK 7 and 8) with Ant, Maven or Gradle (via gradlew).


Example of how to build on an Ubuntu Docker host:

 cd vsts-dockerfiles/ubuntu-minjava-build

 sudo docker build --tag javaalm/vsts-ubuild-minjava .



Example of how to run a container once the image above is built:

 "docker run -d --privileged --name <Docker container name> javaalm/vsts-ubuild-minjava ./vsts-startup.sh <Team Services Account url> <PAT> <Pool Name> <Agent Name>"



so something like this (but using your Team Services Account, PAT, and Pool and Agent names):

 docker run -d --privileged --name docker-xplat-minjava javaalm/vsts-ubuild-minjava ./vsts-startup.sh https://myaccount.visualstudio.com/ spqnoh4j2sqklayog3ipsjovc3z5njvthpm2o4jdrdre2ztqxxxx default docker-xplat-minjava

