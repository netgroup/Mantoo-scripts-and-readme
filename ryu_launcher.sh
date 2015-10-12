#!/bin/bash

echo -e "\n"
echo "#################################################"
echo "##     DREAMER IP/SDN Hyibrid RYU Launcher     ##"
echo "##                                             ##"
echo "##  The process can last many minutes. Please  ##"
echo "##  wait and do not interrupt the process.     ##"
echo "#################################################"

WORKSPACE="workspace"
cd /home/user/$WORKSPACE/dreamer-ryu/ryu/app
ryu-manager --observe-links ofctl_rest.py rest_topology
