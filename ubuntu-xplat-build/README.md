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
See https://github.com/Microsoft/vsts-dockerfiles/blob/master/ubuntu-minjava-build/

Follow the instructions in the README.md file through "Build the Docker Image" -- you do NOT have to actually create a Docker container from the ubuntu-minjava-build image.


---
### Setup and/or run an Docker Host or VM

This Dockerfile was built and tested on an Ubuntu 16.04 host running Docker v1.11.2.  Earlier versions may or may not work.

If you don't already have a host running Docker, you can use the Azure QuickStart template to set up one for Ubuntu:
https://github.com/Azure/azure-quickstart-templates/tree/master/docker-simple-on-ubuntu

You should select Ubuntu 16.04.0-LTS as the Ubuntu OS Version (the default is Ubuntu 14.04.4-LTS).


---
### Build the Docker Image

Example of how to build the Docker image on an Ubuntu Docker host:

 **git clone https://github.com/Microsoft/vsts-dockerfiles.git**

 **cd vsts-dockerfiles/ubuntu-xplat-build**

 **sudo docker build --tag javaalm/vsts-ubuild-full .**


---
### Create and Run the Docker Container

To create a build agent container and connect to Visual Studio Team Services, you will need to:

1. Know the Team Services URL (e.g. https://myaccount.visualstudio.com)

2. Create or obtain a Personal Access Token (PAT) from Team Services which has *"Build (read and execute)"* and *"Agent Pools (read, manage)"* priviledges/capabilities 
(see https://www.visualstudio.com/en-us/docs/setup-admin/team-services/use-personal-access-tokens-to-authenticate).

3. Create or obtain a build agent pool in Team Services
(see https://www.visualstudio.com/en-us/docs/release/getting-started/configure-agents)

4. Decide on a name for your build agent (i.e. the name for your agent within the above pool).



Example of how to run a container once the image above is built:

 **docker run -d --privileged --name \<Docker container name\> javaalm/vsts-ubuild-full ./vsts-startup.sh \<Team Services Account url\> \<PAT\> \<Pool Name\> \<Agent Name\>**



so something like this (but using your Team Services Account, PAT, and Pool and Agent names):

 docker run -d --privileged --name docker-ubuild-full javaalm/vsts-ubuild-full ./vsts-startup.sh https://myaccount.visualstudio.com/ spqnoh4j2sqklayog3ipsjovc3z5njvthpm2o4jdrdre2ztqxxxx default docker-ubuild-full

The expected output from the run comand is the ID of the container created.  It will look something like this:
4f812a7b4f0e0c681eb3616cb04d0797eda37e32d1e5b35f79dfa686d95b3aee


To verify the container is running (and continues to run), run:
 **docker ps -a**

If the STATUS field indicates the container "exited" then something went wrong.  First, check to make sure the spelling of everything on the "docker run" command is correct.  Second, the most likely failure is a lack of the correct Team Services permissions for the PAT.


---
### Debug Failures


As mentioned above, the mostly likely cause of the container prematurely exiting and thus failing is 1) a mistyping on the "docker run" command line and 2) lack of proper permissions for the PAT to enable the creation of a build pool agent.

To debug what is happening, you can run the Docker container interactively by using the command:

 **docker run -it javaalm/vsts-ubuild-full**

This should place you inside of a newly running container.  From here you can manually run the command to start the agent:

 **./vsts-startup.sh \<Team Services Account url\> \<PAT\> \<Pool Name\> \<Agent Name\>**

Once your OS prompt returns, you can look at the contents of a log to see the error by typing:

 **cat ../vsts.install.log.txt**

If you are having Team Services permission issues, make sure the User that created the PAT has the proper permissions following the documentation provided in step 2 above under "Create and Run the Docker Container".

When you are done debugging, exit the container by typing:
 **exit**

