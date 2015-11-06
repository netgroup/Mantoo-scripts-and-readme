#!/bin/bash

if [ $1 ]; then

	echo -e "\n"
	echo "#################################################"
	echo "##     DREAMER IP/SDN service Launcher         ##"
	echo "##                                             ##"
	echo "##    The process can last some minutes.       ##"
	echo "##          Please be patient :-)              ##"
	echo "#################################################"

	cp /home/user/workspace/Dreamer-Mininet-Extensions/vll_pusher.cfg /home/user/workspace/Dreamer-VLL-Pusher/ryu/
	cd /home/user/workspace/Dreamer-VLL-Pusher/ryu/
	./vll_pusher.py --controller $1:8080 --add

else

	echo "Usage: specify controller ip!!"

fi


