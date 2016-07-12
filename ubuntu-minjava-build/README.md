# ubuntu-minjava-build

Dockerfile and shell script to build an Ubuntu docker container to run the Team Services coreCLR build agent for building
Java (OpenJDK 7 and 8) with Ant, Maven or Gradle (via gradlew).


To learn more about how Visual Studio Team Services supports building and continous integration with Java see:
http://java.visualstudio.com/Docs/gettingstarted/buildwebapp


This Dockerfile was built and tested on an Ubuntu 16.04 host running Docker v1.11.2.  Earlier versions may or may not work.
If you don't already have a host running Docker, you can use the Azure QuickStart template to set up one for Ubuntu:
https://github.com/Azure/azure-quickstart-templates/tree/master/docker-simple-on-ubuntu



Example of how to build on an Ubuntu Docker host:

 cd vsts-dockerfiles/ubuntu-minjava-build

 sudo docker build --tag javaalm/vsts-ubuild-minjava .



To create a build agent and connect to Visual Studio Team Services, you will need to:
#. Know the Team Services URL (e.g. https://myaccount.visualstudio.com)
#. Create or obtain a Personal Access Token (PAT) from Team Services which has "build" priviledges/capabilities 
(see https://www.visualstudio.com/en-us/docs/setup-admin/team-services/use-personal-access-tokens-to-authenticate).
#. Create or obtain a build agent pool in Team Services
(see https://www.visualstudio.com/en-us/docs/release/getting-started/configure-agents)
#. Decide on a name for your build agent (i.e. the name for your agent within the above pool).



Example of how to run a container once the image above is built:

 docker run -d --privileged --name \<Docker container name\> javaalm/vsts-ubuild-minjava ./vsts-startup.sh \<Team Services Account url\> \<PAT\> \<Pool Name\> \<Agent Name\>



so something like this (but using your Team Services Account, PAT, and Pool and Agent names):

 docker run -d --privileged --name docker-xplat-minjava javaalm/vsts-ubuild-minjava ./vsts-startup.sh https://myaccount.visualstudio.com/ spqnoh4j2sqklayog3ipsjovc3z5njvthpm2o4jdrdre2ztqxxxx default docker-xplat-minjava

