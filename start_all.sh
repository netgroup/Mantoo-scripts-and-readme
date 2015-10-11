#!/bin/bash


start() {

	killall python
	killall node

	xfce4-terminal -T django -e 'env PROMPT_COMMAND="
	unset PROMPT_COMMAND
	history -s python manage.py runserver 0.0.0.0:8090
	python manage.py runserver 0.0.0.0:8090" bash' --working-directory=/home/user/workspace/Dreamer-Topology-and-Service-Validator &

	sleep 1

	xfce4-terminal -T node.js -e 'env PROMPT_COMMAND="
	unset PROMPT_COMMAND
	history -s node\ app.js
	node app.js" bash' --working-directory=/home/user/workspace/Dreamer-Experiment-Handler &

	sleep 3

	firefox file:///home/user/workspace/Dreamer-Topology3D/index.html

	#chromium-browser file:///home/user/workspace/Dreamer-Topology3D/index.html

}

update() {

	xfce4-terminal -T update -e 'env PROMPT_COMMAND="
	unset PROMPT_COMMAND
	history -s ./update_all.sh
	./update_all.sh" bash' --working-directory=/home/user
}

update_my() {

	xfce4-terminal -T update -e 'env PROMPT_COMMAND="
	unset PROMPT_COMMAND
	history -s ./update_all.sh\ my_workspace
	./update_all.sh my_workspace" bash' --working-directory=/home/user

}

$1
