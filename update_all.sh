#!/bin/bash

REPO_PATH=/home/user/workspace

if [ "$1" = "my_workspace" ];then
	REPO_PATH=/home/user/my_workspace
fi	

UPDATE_ALL_BODY=./update_all_body.sh
if [ "$1" = "bitbucket" ];then
	UPDATE_ALL_BODY="./update_all_body.sh bitbucket"
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
		echo ""
  		# It will enter here if $REPO_dir exists.
		printandexec cd $REPO_DIR

		if [ "$(git status | grep 'nothing to commit, working directory clean')" ]; then
			#echo "nothing to commit, working directory clean"
			git pull
		else
		#if [ ! "$(git status | grep 'nothing to commit, working directory clean')" ]; then
			printandexec git status
			echo ""
			echo "Your working directory $REPO_DIR has some changes."
			echo "What do you want to do:"
			echo "- Delete (stash) your changes and pull from git [d/D]"
			echo "- Do nothing (skip pull) [n/N]"
			echo "- Try to pull [Press any other key]"
			read -r -p "? " response
			if [[ $response =~ ^([dD])$ ]]; then
	    		printandexec git stash
	    		printandexec git pull
	    	else
				if [[ $response =~ ^([nN])$ ]]; then
					echo "skipped"
		    	else
		    		printandexec git pull
		    	fi
			fi
		fi	
	fi
done

#printandexec ./update_all_body.sh
printandexec $UPDATE_ALL_BODY
echo ""
read -r -p "Press enter to exit" response
