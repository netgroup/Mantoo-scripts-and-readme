#!/bin/bash



if [ $1 ]; then



	echo -e "\n"

	echo "#################################################"

	echo "##     DREAMER IP/SDN service Launcher         ##"

	echo "##                                             ##"

	echo "##  The process can last many minutes. Please  ##"

	echo "##  wait and do not interrupt the process.     ##"

	echo "#################################################"



	cp workspace/Dreamer-Mininet-Extensions/vll_pusher.cfg workspace/Dreamer-VLL-Pusher/ryu/

	cd workspace/Dreamer-VLL-Pusher/ryu/

	./vll_pusher.py --controller $1:8080 --add



else

	echo "Usage: specify controller ip!!"



fi


