########################################################################################################
#  OSHI VM - OSHI Virtual Machine
########################################################################################################

This Virtual Machine provides a ready-to-go environment to run experiments related to the OSHI framework

OSHI Home Page : http://netgroup.uniroma2.it/OSHI/ 

Please refer to the OSHI Home Page for further information.

Readme version: 2015-10-16
The updated version of this readme is available at http://netgroup.uniroma2.it/twiki/bin/view/Oshi/ReadMe

#########################################################################################################
#TABLE OF CONTENT OF THIS README
#########################################################################################################

0.  Introduction
0.1 Release notes
1.  Local execution of the Topology3D (Web GUI) and local deployment of topologies over mininet
2.  Emulation example #1 - Deployment of a PW (PseudoWire) and a VLL (IP Virtual Leased Line)
3.  Emulation example #2 - Deployment of Virtual Switches

##########################################################################################
### 0. Introduction
##########################################################################################

The OSHI-VM contains all the projects related to OSHI, in the folder /home/user/workspace/

- Dreamer-Mininet-Extensions
- Dreamer-VLL-Pusher

- Dreamer-Topology3D
- Dreamer-Topology-and-Service-Validator
- Dreamer-Topology-Parser

- Dreamer-Testbed-Deployer
- Dreamer-Management-Scripts  

- Dreamer-Experiment-Handler
- Dreamer-Measurements-Tools

- Dreamer-ryu                
- floodlight-0.90            

- sdn-te-sr-tools      (See the Segment Routing section in the website) 

*** Dreamer-Mininet-Extensions
It extends Mininet in order to allow the emulation of OSHI nodes in this tool
(by default Mininet does not support the deployment of OSHI nodes)

*** Dreamer-VLL-Pusher
It is a python script that installs the tunnels (Virtual Leased Lines and Pseudo Wires)
between the Customer Edge Router (CER)
This is realized leveraging the REST API of the Topology's module and OFCTL's module of the RYU controller

*** Dreamer-Topology3D
Topology 3D (Designer Deployer & Director) a web GUI to design and control SDN experiments.

*** Dreamer-Topology-and-Service-Validator
Topology and Service Validator is a server-side component used together with the Topology3D web GUI.
It is a django python app that stores the model/layer abstractions and their constraints,
and it is able to validate the topologies created through the Topology3D.

*** Dreamer-Topology-Parser
This tool is used to parse and validate the topologies created with Topology3D before deploying
them over testbeds

*** Dreamer-Testbed-Deployer
This tool produces the testbed configuration files to be used by the Management Scripts.

*** Dreamer-Management-Scripts  
Scripts to install and configure a DREAMER testbed both on GOFF and OFELIA facilities.
They include setup scripts, config scripts and remote control scripts for different
types of nodes to be managed.

*** Dreamer-Experiment-Handler
Experiment-Handler controls emulated SDN testbeds interacting with the web GUI
provided by Topology3D. It uses the Mininet emulator and provides the server side elements
that allocates and controls Mininet nodes. 

*** Dreamer-Measurements-Tools
Measurements Tools for OSHI experiment. 
It allows to run iperf experiment on OSHI testbed and collect CPU load
of VMs thanks to xentop tool.

*** Dreamer-ryu                
It contains a customized version of the RYU controller
This version does not install any rule for the LLDP packets in the OpenFlow switches
and offers the getRoute REST API
(it accepts two endpoints as input and returns as output the shortest path that connects them)
The Ryu controller is modified with the patch contained in Dreamer-VLL-Pusher

*** floodlight-0.90 
local copy of floodlight 0.90 

*** sdn-te-sr-tools  
tools for SDN based Traffic Engineering 

##########################################################################################
### 0.1 Release notes
##########################################################################################

OSHI-VM_5 released 2015-10-10
- A launcher icon named "go" on the desktop is used to launch the Topology3D GUI 
  on the Firefox browser and the django and node.js backends with a single click
- A launcher icon named "update" is used to sync up all the folder with the
  corresponding repositories on github
- Several improvements in the Topology3D GUI
  
OSHI_VM4 released 2015-07-18

##########################################################################################
### 1. Local execution of the Topology3D (Web GUI) and local deployment of topologies over mininet 
##########################################################################################

THE OPERATIONS DESCRIBED HEREAFTER CAN ALSO EXECUTED BY CLICKING
ON THE "go" LAUNCHER ICON ON THE DESKTOP. IF AN EXECUTION IS RUNNING
CLICKING AGAIN ON THE "go" LAUNCHER ICON CLEARS EVERYTHING.

In order to run locally the topology3D server and automatically deploy topologies on mininet emulator

open a new terminal shell and run django: 
$ cd /home/user/workspace/Dreamer-Topology-and-Service-Validator
$ python manage.py runserver 0.0.0.0:8090

open a new terminal shell and run node.js:
$ cd cd /home/user/workspace/Dreamer-Experiment-Handler$ 
$ node app.js

Open the web page of the Topology3D using Firefox
/home/user/workspace/Dreamer-Topology3D/index.html

##########################################################################################
### 2. Emulation example #1 - Deployment of a PW (PseudoWire) and a VLL (IP Virtual Leased Line)
##########################################################################################

Three projects are needed to run this Mininet experiment:

1) Dreamer-Mininet-Extensions
2) dreamer-ryu 
3) Dreamer-VLL-Pusher

- Starting the emulation:

1) Run the mininet_deployer script:
   - user@OSHI-VM:~/workspace/Dreamer-Mininet-Extensions$ sudo ./mininet_deployer.py --topology topo/topo_vll_pw.json

2) Wait for the end of the execution (you can see the Mininet CLI "mininet>").
Now the topology is started and properly configured.

3) With the command "xterm node", where node is the name of a node in the topology,
you can open a terminal in this specific node and run commands.
For example, you can monitor the evolution of the IP routing in a OSHI node, try a ping, etc...;

4) Now open two xterm on the controller of the topology, in the first terminal start the RYU controller:
   - xterm ctr8 ctr8 
   - root@OSHI-VM:~/workspace/ryu/ryu/app# ryu-manager rest_topology.py ofctl_rest.py --observe-links

5) Try the ping among two CERs
(the first Ethernet interface is for the IP service, while the others are used for the VLL and the PW):
   - xterm cer1
   - ping 10.0.11.2 // At this point, the ping does not work, because the MPLS circuits have not been installed

6) In the second ctr's xterm, copy the vll_pusher.cfg (that was generated by the mininet_deployer script)
in the folder "Dreamer-VLL-Pusher/ryu". This file is necessary for the installation of the virtual circuits:
   - root@OSHI-VM:~/workspace/Dreamer-Mininet-Extensions# cp vll_pusher.cfg ../Dreamer-VLL-Pusher/ryu

7) Create the virtual circuits, running these commands in the ctr8's xterm:
   - root@OSHI-VM:~/workspace/Dreamer-VLL-Pusher/ryu# rm *.json // Delete the DB of the vcs.
   - root@OSHI-VM:~/workspace/Dreamer-VLL-Pusher/ryu# ./vll_pusher.py --controller localhost:8080 --add // Add the vcs

8) Try again the previous ping. Now it works.

- Stop the emulation:

1) Delete the virtual circuits:
   - root@OSHI-VM:~/workspace/Dreamer-VLL-Pusher/ryu# ./vll_pusher.py --controller localhost:8080 --del

2) Close the xterms (in the terminals):
   - exit or ctrl + D;
   
3) Stop the emulation (in the Mininet CLI):
   - exit or ctrl + D;

4) Wait for the conclusion.

##########################################################################################
### 3. Emulation example #2 - Deployment of Virtual Switches
##########################################################################################

- Emulation start:

1) Run the script deployer_example:
   - user@OSHI-VM:~/workspace/Dreamer-Mininet-Extensions$ sudo ./deployer_example.py

2) Wait for the end of the execution (you can see the Mininet CLI "mininet>").
At this step, the topology is started and properly configured.

3) Now open two xterm on the controller of the topology, in the first terminal start the RYU controller:
   - xterm ctr1 ctr1 
   - root@OSHI-VM:~/workspace/ryu/ryu/app# ryu-manager rest_topology.py ofctl_rest.py --observe-links

4) Try the ping among two CER (the first Ethernet interface is for the IP service, while the other are used for the VSs):
   - xterm cer1
   - ping 10.0.11.2 // At this point, the ping does not work, because the MPLS circuits have not been installed

5) In the second ctr1's xterm, copy the vll_pusher.cfg (that was generated by the deployer_example script)
in the folder "Dreamer-VLL-Pusher/ryu". This file is necessary for the installation of the virtual circuits:
   - root@OSHI-VM:~/workspace/Dreamer-Mininet-Extensions# cp vll_pusher.cfg ../Dreamer-VLL-Pusher/ryu

6) Create the virtual circuits, running these commands in the ctr1's xterm:
   - root@OSHI-VM:~/workspace/Dreamer-VLL-Pusher/ryu# rm *.json // Delete the DB of the vcs.
   - root@OSHI-VM:~/workspace/Dreamer-VLL-Pusher/ryu# ./vll_pusher.py --controller localhost:8080 --add // Add the vcs

7) Try again the previous ping. Now it works.

- Emulation stop:

1) Delete the virtual circuits:
   - root@OSHI-VM:~/workspace/Dreamer-VLL-Pusher/ryu# ./vll_pusher.py --controller localhost:8080 --del

2) Close the xterms (in the terminals):
   - exit or ctrl + D;
   
3) Stop the emulation (in the Mininet CLI):
   - exit or ctrl + D;

4) Wait for the conclusion.

##########################################################################################

Tutorial to run experimental topologies of OSHI network in the OFELIA/GOFF testbeds:
http://netgroup.uniroma2.it/twiki/pub/Oshi/WebHome/ofelia-experiment.pdf
