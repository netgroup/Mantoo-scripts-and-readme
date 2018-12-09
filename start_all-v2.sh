#!/bin/bash

#version for ubuntu 18.04 

clear_all() {

	rm /home/user/workspace/Dreamer-VLL-Pusher/ryu/*.json > /dev/null
	kill -9 $(ps ax | grep -m 1 "python manage.py runserver 0.0.0.0:8000" | awk '{print $1}') &> /dev/null
	kill $(pidof npm start) &> /dev/null
	kill $(pidof node app.js) &> /dev/null
	#kill $(ps ax | grep -m 1 'chromium-browser http://localhost:8000' | awk '{print $1}') &> /dev/null
	kill $(ps ax | grep -m 1 'chrome http://localhost:8000' | awk '{print $1}') &> /dev/null

	TERM_TO_KILL=$(ps ax | grep -m 2 "xfce4-terminal --disable-server" | awk '{print $1}')

	for TERM in ${TERM_TO_KILL[@]}; 
	do
		echo $TERM
		kill $TERM	&> /dev/null	
	done

	TERM_TO_KILL2=$(ps ax | grep "quagga" | grep -v "grep" | awk '{print $1}')

	for TERM in ${TERM_TO_KILL2[@]}; 
	do
		echo $TERM
		sudo kill $TERM	&> /dev/null	
	done

	TERM_TO_KILL3=$(ps ax | grep "ovsdb-server" | grep -v "grep" | awk '{print $1}')

	for TERM in ${TERM_TO_KILL3[@]}; 
	do
		echo $TERM
		sudo kill $TERM	&> /dev/null	
	done

	TERM_TO_KILL4=$(ps ax | grep "ovs-vswitchd" | grep -v "grep" | awk '{print $1}')

	for TERM in ${TERM_TO_KILL4[@]}; 
	do
		echo $TERM
		sudo kill $TERM	&> /dev/null	
	done

	TERM_TO_KILL5=$(ps ax | grep "/usr/sbin/sshd -o UseDNS=no -u0" | grep -v "grep" | awk '{print $1}')

	for TERM in ${TERM_TO_KILL5[@]}; 
	do
		echo $TERM
		sudo kill $TERM	&> /dev/null	
	done


	#if [ "$(ps ax | grep -c 'mininet:')" -gt 1 ]; then
	sudo mn -c &> /dev/null
	#fi

}

stop() {
	clear_all
	sudo service openvswitch-switch start

}


start() {

	clear_all

	xfce4-terminal --disable-server -T RDCL_3D -e 'env PROMPT_COMMAND=" 
	unset PROMPT_COMMAND
	source env/bin/activate
	history -s python manage.py runserver 0.0.0.0:8000 
	python manage.py runserver 0.0.0.0:8000" bash' --working-directory=/home/user/workspace/RDCL3D/code &

	sleep 1

	xfce4-terminal --disable-server -T OSHI_AGENT -e 'env PROMPT_COMMAND=" 
	unset PROMPT_COMMAND
	history -s npm start 
	npm start" bash' --working-directory=/home/user/workspace/rdcl-agent &

	sleep 4

	#chromium-browser http://localhost:8000
	google-chrome http://localhost:8000

}

update() {

	xfce4-terminal -T update -e 'env PROMPT_COMMAND=" 
	unset PROMPT_COMMAND
	history -s ./update_all.sh 
	./update_all.sh" bash' --working-directory=/home/user	

}

$1