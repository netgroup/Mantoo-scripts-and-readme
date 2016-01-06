#!/bin/bash

if [ $# -eq 0 ]
  then
 	echo "#################################################"
	echo "##     OSHI Hybrid IP/SDN Hybrid ryu_start     ##"
	echo "##                                             ##"
	echo "##  The process can last many minutes. Please  ##"
	echo "##  wait and do not interrupt the process.     ##"
	echo "#################################################"

	WORKSPACE="workspace"
	cd /home/user/$WORKSPACE/dreamer-ryu/ryu/app
	ryu-manager --verbose --observe-links ofctl_rest.py rest_topology
fi

while [[ $# > 1 ]]
do
key="$1"
case $key in
    -m|--mode)
    MODE="$2"
    shift # past argument
    ;;
esac
shift
done
if [[ ${MODE} = 'monitoring' ]]
	then
		echo "##################################################"
		echo "##     OSHI Hybrid IP/SDN Hybrid ryu_start      ##"
		echo "##         with a monitoring processing   	  ##"
		echo "##       The process can last many minutes.     ##"
		echo "## Please wait and do not interrupt the process ##"
		echo "##################################################"

		WORKSPACE="workspace"
		cd /home/user/$WORKSPACE/dreamer-ryu/ryu/app
		ryu-manager --verbose --observe-links ofctl_rest.py rest_topology /home/user/workspace/OSHI-monitoring/traffic_monitor.py 
else 
          echo "Unrecognized option. Available options are: setup, runmininet and runryu. This script will now terminate."
          exit 1
fi
