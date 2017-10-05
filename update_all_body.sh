#!/bin/bash

REPO_PATH=/home/user/workspace

if [ "$1" = "my_workspace" ];then
	REPO_PATH=/home/user/my_workspace
fi	

#if [ "$1" = "bitbucket" ];then
echo "PARAMETER: $1"
#fi	

if [ "$1" != "bitbucketonly" ];then

#REPOS[0]=Mantoo-scripts-and-readme
#https://github.com/netgroup/Mantoo-scripts-and-readme.git

REPOS[0]=Dreamer-Testbed-Deployer
#https://github.com/netgroup/Dreamer-Testbed-Deployer

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

REPOS[10]=Dreamer-Experiment-Handler
#https://github.com/netgroup/Dreamer-Experiment-Handler.git

REPOS[11]=OSHI-monitoring
#https://github.com/netgroup/OSHI-monitoring.git

REPOS[12]=OSHI-REST-server
#https://github.com/netgroup/OSHI-REST-server.git

REPOS[13]=sdn-te-sr-tools
#https://github.com/netgroup/SDN-TE-SR-tools.git

REPOS[14]=RDCL3D
#https://github.com/superfluidity/RDCL3D.git

REPOS[15]=rdcl-agent
#https://github.com/netgroup/rdcl-agents.git

REPOS[16]=srv6-mantoo
#https://github.com/netgroup/srv6-mantoo.git


fi	

if [[ "$1" = "bitbucket" || "$1" = "bitbucketonly" ]];then
	REPOS[17]=test-rdcl
	#https://ssalsano@bitbucket.org/ssalsano/test-rdcl.git

	REPOS[18]=rdcl-agent
	#https://ssalsano@bitbucket.org/ssalsano/rdcl-agent.git
fi	


printandexec () {
		echo "$@"
		eval "$@"
}

for REPO_NAME in ${REPOS[@]}; 
do
	REPO_DIR="$REPO_PATH/$REPO_NAME"
	if [ -d $REPO_DIR ]; then
		echo ""
  		# It will enter here if $REPO_dir exists.
		printandexec cd $REPO_DIR

		if [ "$(git status | grep 'nothing to commit')" ]; then
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
		if [ "$1" = "clone_repos" ];then
			cd $REPO_PATH
			if [ "$REPO_NAME" = "RDCL3D" ];then
				printandexec git clone https://github.com/superfluidity/$REPO_NAME.git
				cd $REPO_NAME/code
				printandexec virtualenv env
			else
				printandexec git clone https://github.com/netgroup/$REPO_NAME.git
			fi
		fi	


	fi
done

MIGRATE_REPOS[0]=RDCL3D
#https://github.com/superfluidity/RDCL3D.git

if [[ "$1" = "bitbucket" || "$1" = "bitbucketonly" ]];then
	MIGRATE_REPOS[1]=test-rdcl
	#https://ssalsano@bitbucket.org/ssalsano/test-rdcl.git
fi	


for REPO_NAME in ${MIGRATE_REPOS[@]}; 
do
	REPO_DIR="$REPO_PATH/$REPO_NAME"
	if [ -d $REPO_DIR ]; then
		echo ""
  		# It will enter here if $MIGRATE_REPO_dir exists.
		printandexec cd $REPO_DIR/code

		printandexec source env/bin/activate
		printandexec pip install -r requirements.txt
		printandexec python manage.py makemigrations sf_user projecthandler deploymenthandler
		printandexec python manage.py migrate
		printandexec deactivate

	else 
		echo ""
		echo "Directory $REPO_DIR is not present"
	fi
done


UPDATE_AGENTS[0]=rdcl-agent
#https://github.com/superfluidity/RDCL3D.git

if [[ "$1" = "bitbucket" || "$1" = "bitbucketonly" ]];then
	UPDATE_AGENTS[1]=test-rdcl
	#https://ssalsano@bitbucket.org/ssalsano/test-rdcl.git
fi	


for REPO_NAME in ${UPDATE_AGENTS[@]}; 
do
	REPO_DIR="$REPO_PATH/$REPO_NAME"
	if [ -d $REPO_DIR ]; then
		echo ""
  		# It will enter here if $MIGRATE_REPO_dir exists.
		printandexec cd $REPO_DIR

		printandexec npm install 

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
