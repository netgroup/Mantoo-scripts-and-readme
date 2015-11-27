#!/bin/bash

REPO_PATH=/home/user/workspace

if [ "$1" = "my_workspace" ];then
	REPO_PATH=/home/user/my_workspace
fi	

REPOS[0]=$REPO_PATH/Dreamer-Experiment-Handler
#https://github.com/netgroup/Dreamer-Experiment-Handler.git

REPOS[1]=$REPO_PATH/Dreamer-Management-Scripts
#https://github.com/netgroup/Dreamer-Management-Scripts.git

REPOS[2]=$REPO_PATH/Dreamer-Measurements-Tools
#https://github.com/netgroup/Dreamer-Measurements-Tools.git

REPOS[3]=$REPO_PATH/Dreamer-Mininet-Extensions
#https://github.com/netgroup/Dreamer-Mininet-Extensions.git

REPOS[4]=$REPO_PATH/dreamer-ryu
#https://github.com/netgroup/dreamer-ryu.git

REPOS[5]=$REPO_PATH/Dreamer-Topology3D
#https://github.com/netgroup/Dreamer-Topology3D.git

REPOS[6]=$REPO_PATH/Dreamer-Topology-and-Service-Validator
#https://github.com/netgroup/Dreamer-Topology-and-Service-Validator.git

REPOS[7]=$REPO_PATH/Dreamer-Topology-Parser-and-Validator
#https://github.com/netgroup/Dreamer-Topology-Parser.git

REPOS[8]=$REPO_PATH/Dreamer-VLL-Pusher
#https://github.com/netgroup/Dreamer-VLL-Pusher.git

REPOS[9]=$REPO_PATH/floodlight-0.90
#https://github.com/netgroup/floodlight.git

REPOS[10]=$REPO_PATH/Mantoo-scripts-and-readme
#https://github.com/netgroup/Mantoo-scripts-and-readme.git

REPOS[11]=$REPO_PATH/OSHI-monitoring
#https://github.com/netgroup/OSHI-monitoring.git

REPOS[12]=$REPO_PATH/OSHI-REST-server
#https://github.com/netgroup/OSHI-REST-server.git

REPOS[13]=$REPO_PATH/sdn-te-sr-tools
#https://github.com/netgroup/SDN-TE-SR-tools.git

REPOS[14]=$REPO_PATH/Dreamer-Testbed-Deployer
#https://github.com/netgroup/Dreamer-Testbed-Deployer

printandexec () {
		echo "$@"
		eval "$@"
}

for REPO_DIR in ${REPOS[@]}; 
do
	if [ -d $REPO_DIR ]; then
  		# It will enter here if $REPO_dir exists.
		printandexec cd $REPO_DIR

		if [ ! "$(git status | grep 'nothing to commit, working directory clean')" ]; then
			echo "Changes not staged for commit, delete all?"
			read -r -p "Are you sure? [y/N] " response
			if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
	    		git stash
	    		git pull
			fi
		else
			git pull
		fi	
	fi
done
read -r -p "Press enter to exit" response
