#!/bin/bash

REPO_PATH=/home/user/workspace

if [ "$1" = "my_workspace" ];then
	REPO_PATH=/home/user/my_workspace
fi	


REPOS[0]=$REPO_PATH/Mantoo-scripts-and-readme
#https://github.com/netgroup/Mantoo-scripts-and-readme.git


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

printandexec ./update_all_body.sh

read -r -p "Press enter to exit" response
