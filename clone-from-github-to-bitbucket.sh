#!/bin/bash

# $1 is used to pass username:password (or username if you want to manually insert the password)

REPO_PREFIX=q
REMOTE_NAME=q

REPO_PATH=/home/user/workspace

REPOS[0]=Dreamer-Experiment-Handler
#https://github.com/netgroup/Dreamer-Experiment-Handler.git

REPOS[1]=Dreamer-Management-Scripts
#https://github.com/netgroup/Dreamer-Management-Scripts.git

REPOS[2]=Dreamer-Measurements-Tools
#https://github.com/netgroup/Dreamer-Measurements-Tools.git

REPOS[3]=Dreamer-Mininet-Extensions
#https://github.com/netgroup/Dreamer-Mininet-Extensions.git

REPOS[4]=dreamer-ryu
#https://github.com/netgroup/dreamer-ryu.git

REPOS[5]=Dreamer-Topology3D
#https://github.com/netgroup/Dreamer-Topology3D.git

REPOS[6]=Dreamer-Topology-and-Service-Validator
#https://github.com/netgroup/Dreamer-Topology-and-Service-Validator.git

REPOS[7]=Dreamer-Topology-Parser-and-Validator
#https://github.com/netgroup/Dreamer-Topology-Parser.git

REPOS[8]=Dreamer-VLL-Pusher
#https://github.com/netgroup/Dreamer-VLL-Pusher.git

REPOS[9]=floodlight-0.90
#https://github.com/netgroup/floodlight.git

REPOS[10]=Mantoo-scripts-and-readme
#https://github.com/netgroup/Mantoo-scripts-and-readme.git

REPOS[11]=OSHI-monitoring
#https://github.com/netgroup/OSHI-monitoring.git

REPOS[12]=OSHI-REST-server
#https://github.com/netgroup/OSHI-REST-server.git

REPOS[13]=sdn-te-sr-tools
#https://github.com/netgroup/SDN-TE-SR-tools.git

REPOS[14]=Dreamer-Testbed-Deployer
#https://github.com/netgroup/Dreamer-Testbed-Deployer

printandexec () {
		echo "$@"
		eval "$@"
}

for REPO_DIR in ${REPOS[@]}; 
do
	if [ -d $REPO_PATH/$REPO_DIR ]; then
  		# It will enter here if $REPO_dir exists.
		printandexec cd $REPO_PATH/$REPO_DIR

		printandexec curl -v --user $1 https://api.bitbucket.org/1.0/repositories/ --data name=$REPO_PREFIX$REPO_DIR --data is_private='true'
		printandexec git remote add $REMOTE_NAME https://bitbucket.org/ssalsano/q$REPO_DIR.git
		printandexec git push $REMOTE_NAME master
		read -r -p "Press enter to continue" response

	fi
done
read -r -p "Press enter to exit" response
