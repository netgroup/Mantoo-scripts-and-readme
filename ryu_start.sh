#!/bin/bash
echo -e "\n"
echo "#################################################"
echo "##     OSHI Hybrid IP/SDN Hybrid ryu_start     ##"
echo "##                                             ##"
echo "##  The process can last many minutes. Please  ##"
echo "##  wait and do not interrupt the process.     ##"
echo "#################################################"

WORKSPACE="workspace"
cd /home/user/$WORKSPACE/dreamer-ryu/ryu/app
ryu-manager --verbose --observe-links ofctl_rest.py rest_topology
