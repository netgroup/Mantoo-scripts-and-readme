#!/bin/bash

REPO_PATH=/home/user/workspace

if [ "$1" = "my_workspace" ];then
	REPO_PATH=/home/user/my_workspace
fi	

REPOS[0]=$REPO_PATH/Dreamer-Testbed-Deployer
REPOS[1]=$REPO_PATH/Dreamer-Management-Scripts
REPOS[2]=$REPO_PATH/Dreamer-Measurements-Tools
REPOS[3]=$REPO_PATH/Dreamer-Mininet-Extensions
REPOS[4]=$REPO_PATH/dreamer-ryu
REPOS[5]=$REPO_PATH/Dreamer-Topology3D
REPOS[6]=$REPO_PATH/Dreamer-Topology-and-Service-Validator
REPOS[7]=$REPO_PATH/Dreamer-Topology-Parser-and-Validator
REPOS[8]=$REPO_PATH/Dreamer-VLL-Pusher
REPOS[9]=$REPO_PATH/floodlight-0.90
REPOS[10]=$REPO_PATH/Dreamer-Experiment-Handler
REPOS[11]=$REPO_PATH/OSHI-monitoring
REPOS[12]=$REPO_PATH/OSHI-REST-server
REPOS[13]=$REPO_PATH/sdn-te-sr-tools
REPOS[14]=$REPO_PATH/Mantoo-scripts-and-readme



printandexec () {
		echo "$@"
		eval "$@"
}

for REPO_DIR in ${REPOS[@]}; 
do
	if [ -d $REPO_DIR ]; then
  		# It will enter here if $REPO_dir exists.
  		echo ""
		printandexec cd $REPO_DIR
		printandexec git status
	else 
		echo ""
		echo "Directory $REPO_DIR is not present"
	fi

done

echo ""
read -r -p "Press enter to exit" response