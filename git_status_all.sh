#!/bin/bash

REPO_PATH=/home/user/workspace

if [ "$1" = "my_workspace" ];then
	REPO_PATH=/home/user/my_workspace
fi	

REPOS[0]=$REPO_PATH/Dreamer-Experiment-Handler
REPOS[1]=$REPO_PATH/Dreamer-Management-Scripts
REPOS[2]=$REPO_PATH/Dreamer-Measurements-Tools
REPOS[3]=$REPO_PATH/Dreamer-Mininet-Extensions
REPOS[4]=$REPO_PATH/dreamer-ryu
REPOS[5]=$REPO_PATH/Dreamer-Topology3D
REPOS[6]=$REPO_PATH/Dreamer-Topology-and-Service-Validator
REPOS[7]=$REPO_PATH/Dreamer-Topology-Parser-and-Validator
REPOS[8]=$REPO_PATH/Dreamer-VLL-Pusher
REPOS[9]=$REPO_PATH/floodlight-0.90
REPOS[10]=$REPO_PATH/Mantoo-scripts-and-readme



printandexec () {
		echo "$@"
		eval "$@"
}

for REPO_DIR in ${REPOS[@]}; 
do
	printandexec cd $REPO_DIR
	printandexec git status


done

read -r -p "Press enter to exit" response