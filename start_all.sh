#!/bin/bash

stop() {

	rm /home/user/workspace/Dreamer-VLL-Pusher/ryu/*.json > /dev/null
	kill -9 $(ps ax | grep -m 1 "python manage.py runserver 0.0.0.0:8090" | awk '{print $1}') &> /dev/null
	kill $(pidof node app.js) &> /dev/null
	kill $(ps ax | grep -m 1 'firefox -P DT3D -new-instance file:///home/user/workspace/Dreamer-Topology3D/index.html' | awk '{print $1}') &> /dev/null

	TERM_TO_KILL=$(ps ax | grep -m 2 "xfce4-terminal --disable-server" | awk '{print $1}')

	for TERM in ${TERM_TO_KILL[@]}; 
	do
		echo $TERM
		kill $TERM	&> /dev/null	
	done

	TERM_TO_KILL2=$(ps ax | grep "quagga" | awk '{print $1}')

	for TERM in ${TERM_TO_KILL2[@]}; 
	do
		echo $TERM
		kill $TERM	&> /dev/null	
	done

	if [ "$(ps ax | grep -c 'mininet:')" -gt 1 ]; then
		sudo mn -c &> /dev/null
	fi

}


start() {

	stop

	xfce4-terminal --disable-server -T django -e 'env PROMPT_COMMAND=" 
	unset PROMPT_COMMAND
	history -s python manage.py runserver 0.0.0.0:8090 
	python manage.py runserver 0.0.0.0:8090" bash' --working-directory=/home/user/workspace/Dreamer-Topology-and-Service-Validator &

	sleep 1

	xfce4-terminal --disable-server -T node.js -e 'env PROMPT_COMMAND=" 
	unset PROMPT_COMMAND
	history -s node\ app.js 
	node app.js" bash' --working-directory=/home/user/workspace/Dreamer-Experiment-Handler &

	sleep 1

	firefox -P "DT3D" -new-instance file:///home/user/workspace/Dreamer-Topology3D/index.html

}

update() {

	xfce4-terminal -T update -e 'env PROMPT_COMMAND=" 
	unset PROMPT_COMMAND
	history -s ./update_all.sh 
	./update_all.sh" bash' --working-directory=/home/user	

}

$1