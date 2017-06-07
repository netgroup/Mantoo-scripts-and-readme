#!/bin/bash

REPO_PATH=/home/user/workspace

if [ "$1" = "my_workspace" ];then
	REPO_PATH=/home/user/my_workspace
fi	

if [ "$1" = "bitbucket" ];then
	echo "BITBUCKET!!!!!!!!!!!"
fi	

#REPOS[0]=$REPO_PATH/Mantoo-scripts-and-readme
#https://github.com/netgroup/Mantoo-scripts-and-readme.git

REPOS[0]=$REPO_PATH/Dreamer-Testbed-Deployer
#https://github.com/netgroup/Dreamer-Testbed-Deployer

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

REPOS[10]=$REPO_PATH/Dreamer-Experiment-Handler
#https://github.com/netgroup/Dreamer-Experiment-Handler.git

REPOS[11]=$REPO_PATH/OSHI-monitoring
#https://github.com/netgroup/OSHI-monitoring.git

REPOS[12]=$REPO_PATH/OSHI-REST-server
#https://github.com/netgroup/OSHI-REST-server.git

REPOS[13]=$REPO_PATH/sdn-te-sr-tools
#https://github.com/netgroup/SDN-TE-SR-tools.git

REPOS[14]=$REPO_PATH/RDCL3D
#https://github.com/superfluidity/RDCL3D.git

REPOS[15]=$REPO_PATH/rdcl-agents
#https://github.com/netgroup/rdcl-agents.git

if [ "$1" = "bitbucket" ];then
	REPOS[16]=$REPO_PATH/test-rdcl
	#https://ssalsano@bitbucket.org/ssalsano/test-rdcl.git

	REPOS[17]=$REPO_PATH/rdcl-agent
	#https://ssalsano@bitbucket.org/ssalsano/rdcl-agent.git
fi	


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
	else 
		echo ""
		echo "Directory $REPO_DIR is not present"
	fi
done

MIGRATE_REPOS[0]=$REPO_PATH/RDCL3D
#https://github.com/superfluidity/RDCL3D.git

if [ "$1" = "bitbucket" ];then
	MIGRATE_REPOS[1]=$REPO_PATH/test-rdcl
	#https://ssalsano@bitbucket.org/ssalsano/test-rdcl.git
fi	


for REPO_DIR in ${MIGRATE_REPOS[@]}; 
do
	if [ -d $REPO_DIR ]; then
		echo ""
  		# It will enter here if $MIGRATE_REPO_dir exists.
		printandexec cd $REPO_DIR/code

		printandexec source env/bin/activate
		printandexec python manage.py makemigrations sf_user projecthandler deploymenthandler
		printandexec python manage.py migrate
		printandexec deactivate

	else 
		echo ""
		echo "Directory $REPO_DIR is not present"
	fi
done


#read -r -p "Press enter to exit" response


#			if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
#	    		git stash
#	    		git pull
#			fi