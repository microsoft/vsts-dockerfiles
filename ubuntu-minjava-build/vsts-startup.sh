#!/bin/sh
 
cd /home/xplatalm/vsts-agent/
echo URL: $1 > /home/xplatalm/vsts.install.log.txt 2>&1
echo PAT: HIDDEN >> /home/xplatalm/vsts.install.log.txt 2>&1
echo Pool: $3 >> /home/xplatalm/vsts.install.log.txt 2>&1
echo Agent: $4 >> /home/xplatalm/vsts.install.log.txt 2>&1
./config.sh --configure --unattended --nostart --replace --acceptteeeula --url $1 --auth PAT --token $2 --pool $3 --agent $4 >> /home/xplatalm/vsts.install.log.txt 2>&1
./run.sh start >> /home/xplatalm/vsts.install.log.txt 2>&1
