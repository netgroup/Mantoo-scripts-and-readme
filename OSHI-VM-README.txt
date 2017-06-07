########################################################################################################
#  OSHI VM - OSHI Virtual Machine
########################################################################################################

This Virtual Machine provides a ready-to-go environment to run experiments related to the OSHI framework

You may refer to the OSHI Home Page for further information:
http://netgroup.uniroma2.it/OSHI/ 

IMPORTANT: you may UPDATE all the projects in the OSHI Virtual Machine
to their latest version by running the update script
*** simply click the "update" desktop icon ***

Readme version: 2016-06-08
The updated version of this readme is available at http://netgroup.uniroma2.it/twiki/bin/view/Oshi/ReadMe

password for user: 1234 
password for root: root

administrator of RDCL 3D GUI 
login    : admin
password : admin

#########################################################################################################
#TABLE OF CONTENT OF THIS README
#########################################################################################################

0.  Introduction
0.1 Release notes
1.  Guided tour on RDCL3D (web GUI) and local deployment of topologies over mininet
2.  Manual execution of the components 
3.  Emulation example #1 - Deployment of a PW (PseudoWire) and a VLL (IP Virtual Leased Line)
4.  Emulation example #2 - Deployment of Virtual Switches
5.  Segment routing examples

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

- sdn-te-sr-tools 

- RDCL3D
- rdcl-agents

*** Dreamer-Mininet-Extensions
It extends Mininet in order to allow the emulation of OSHI nodes in this tool
(by default Mininet does not support the deployment of OSHI nodes)

*** Dreamer-VLL-Pusher
It is a python script that installs the tunnels (Virtual Leased Lines and Pseudo Wires)
between the Customer Edge Router (CER)
This is realized leveraging the REST API of the Topology's module and OFCTL's module of the RYU controller

*** Dreamer-Topology3D (deprecated)
Topology 3D (Designer Deployer & Director) a web GUI to design and control SDN experiments 
The new web GUI is RDCL 3D

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

*** OSHI-Monitoring
tools for monitoring traffic on links and saving the information in .rrd databases

*** OSHI-REST-server
it can provide various services, currently it creates the .png files with traffic statistics

*** RDCL 3D
RDCL 3D (Design Deploy & Direct) a web GUI to design and control SDN and NFV services and experiments 


##########################################################################################
### 0.1 Release notes
##########################################################################################

OSHI-VM_8 released 2017-06-07
- added the RDCL 3D framework, see https://github.com/superfluidity/RDCL3D

OSHI-VM_7b released 2016-04-01
- added the Segment Routing use case, see Readme in https://github.com/netgroup/SDN-TE-SR-tools
- ecplipse is included as needed for the development of the SR allocation algorithms (in java)
- added the /home/user/workspace/OSHI-Monitoring and /home/user/workspace/OSHI-REST-server folders (not yet fully supported)

OSHI-VM_6b released 2015-11-06
- Added the folder /home/user/workspace/Mantoo-scripts-and-readme
- The update_all.sh script also updates /home/user/workspace/Mantoo-scripts-and-readme
- New version of wireshark (1.12.8) is included
- "Press enter" to exit the update_all.sh script has been added
- The laucher icons in the desktop now points to the scripts in Mantoo-scripts-and-readme
- A launcher icon "stop" has been added 
- A launcher icon "check_status" has been added (git status on all projects)
- /root/ryu_start.sh is a symbolic link to the script in Mantoo-scripts-and-readme
- /home/user/service_start.sh is a symbolic link to the script in Mantoo-scripts-and-readme

OSHI-VM_5 released 2015-10-10
- A launcher icon named "go" on the desktop is used to launch the Topology3D GUI 
  on the Firefox browser and the django and node.js backends with a single click
- A launcher icon named "update" is used to sync up all the folder with the
  corresponding repositories on github
- Several improvements in the Topology3D GUI
  
OSHI_VM4 released 2015-07-18

##########################################################################################
### 1. Guided tour on RDCL 3D (web GUI) and local deployment of topologies over mininet
##########################################################################################

Click on the "go" launcher icon on the desktop.

It starts two terminal shells (running django and node.js) and the Chromium browser,
opened at the RDCL 3D home page.

Click on Projects->More Info and add a new project.
Choose project type OSHI, click on Example project and select example_network_3cr_2p2_2ce.
Enter a project name and click Create.

Click on Oshi type->More Info,
in the list of Oshi descriptors locate example_network_3cr_2pe_2ce 
click on the Action drop down menu, select Show Graph

You can change the view (Data, VLL) using the View button on the left side.

Switch the view to VLL (Virtual Leased Line). 
A VLL between two CER (Customer Edge Router) is shown. This is the service to be
realized.

Go back to the list of Oshi descriptors and select Deploy among the actions.
Give a name to the deployment (e.g. the day or the date).
Click on New agent to create a new deployment agent.
Call it mininet_agent_3030 and provide as URL http://localhost:3030

Click on Deploy, the deployment of the topology on Mininet will start.

Click on Monitoring on the left sidebar and see the topology of the launched deployment.

Right click on a node and select Open console, a terminal shell
on that node will appear as new tab.

You can execute arbitrary commands on the shell of a terminal, for example:
> ip route
> ip addr
> ifconfig
> ping 10.0.0.1
> traceroute 10.0.4.1

Using ip addr and ifconfig, in CRs (Core Routers) and PEs (Provider Edge)
you can identify the "physical" interfaces of the nodes 
ethx (e.g. for a node peo6: peo6-eth0, peo6-eth1, ...) and the "virtual" interfaces
that are visible to the IP routing of the nodes (vi0, vi1, vi2)

You can identify the numbering of the IP networks between PE, CR and CER 10.0.x.y,
of the management interfaces toward the host e.g. 10.255.25x.y,
of the "loopback" addresses of the IP routers: 172.16.0.x

The CER nodes have only the physical interface as they are not Hybrid IP/SDN nodes,
but only IP routers.
In the CER nodes you can identify an interface with the same network
between the two remote CERs, by pinging on this interface there is no answer
(because the VLL is not active at the startup).
On cer7 try to ping cer1 on the tunnel, type:
> ping 10.0.11.1 (not working)

Try a ping or traceroute toward the "regular" address of cer1, type:
> ping 10.0.5.1 (it works)
> traceroute 10.0.5.1 (it works)

You can also ssh to the nodes from a terminal in the host machine
(see their management IP address in the deployment shell tab)

user@OSHI-VM:~$ ssh -X root@10.255.253.1

you can run the same arbitrary commands as listed above and you can launch wireshark:
> wireshark &

In wireshark for example you can capture the OpenFlow packets and the OSPF packets.
At the beginning the controller is not running and you will see the connection attempts
from the switches to the controller. The wireshark filter for OpenFlow is "openflow_v4"
which corresponds to OpenFlow 1.3

On a OSHI node you can operate on the ovs switch. Assume that you are logged in a
PE node called peo2, this command shows all the interfaces bridged in the ovs switch:

> ovs-vsctl --db=unix:/tmp/peo2/ovs/db.sock show

This command dumps the OpenFlow table of the switch

> ovs-ofctl dump-flows peo2 -O OpenFlow13

Now let us start the controller. Press Ctrl and left click on the controller icon
to open the shell tab at the bottom of the Topology3D page.
In the controller shell, type:
> ./ryu_start.sh

The controller starts. If you capture with wireshark on the links among the routers
you will see openflow packet-out and packet-in related to the continuous topology
discovery procedure run by the controller. By capturing on the ethx interfaces 
the LLDP packets can be observed.

Finally let us create the VLL service. During the deployment phase a configuration
file that describes the required VLL services (in this case a single VLL) has been produced.
This configuration file is taken as input by a python script called vll_pusher
that uses the Northbound interface of the ryu controller. It asks ryu to create 
a set of tunnels, one per each VLL to be created. Ryu selects the path considering its 
view of the topology and executing the dijkstra shortest path algorithm.
Ryu creates MPLS tunnels in this example.

In a terminal shell of the host, type:
user@OSHI-VM:~$ ./service_start.sh 10.255.248.1

You can now start the ping among the CERs over the tunnel. From cer7 type:
> ping 10.0.11.1 (it now works)

Compare the traceroute on the tunnel and toward the regular IP address of cer1
> traceroute 10.0.11.1
> traceroute 10.0.5.1

Run wireshark on an OSHI router in the path, for example peo6 
user@OSHI-VM:~$ ssh -X root@10.255.252.1
> wireshark &
If you execute again the ping on the tunnel, you can capture the MPLS packets 
in the interface from peo6 toward one of the core routers.
Note: you need to capture on one of the physical interfaces (peo6-ethx), because
the MPLS packets are not visible on the vix interfaces.


##########################################################################################
### 2. Manual execution of the components 
##########################################################################################

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
### 3. Emulation example #1 - Deployment of a PW (PseudoWire) and a VLL (IP Virtual Leased Line)
##########################################################################################

Three projects are needed to run this Mininet experiment:

1) Dreamer-Mininet-Extensions
2) dreamer-ryu 
3) Dreamer-VLL-Pusher

This example can be executed using the command line (CLI) or the Topology3D GUI (GUI)

1-CLI) Starting the emulation using the command line - Run the mininet_deployer script:
   - user@OSHI-VM:~/workspace/Dreamer-Mininet-Extensions$ sudo ./mininet_deployer.py --topology topo/topo_vll_pw.json

2-CLI) Wait for the end of the execution (you can see the Mininet CLI "mininet>").
Now the topology is started and properly configured.

1-GUI) Load the example topology: from the Topology menu in the top bar, select Import topology from file
Choose the file /home/user/workspace/Dreamer-Mininet-Extensions/topo/topo_vll_pw.json

Deploy the topology: In the left frame, from the Deployment menu, select Deploy.
In the deployment window on the bottom, type deploy and then press enter.

2-GUI) Wait for the end of the deployment (you can see the list of node started with their management IP addresses, then "Starting CLI" and the prompt).
Now the topology is started and properly configured.

3-CLI) With the command "xterm node", where node is the name of a node in the topology,
you can open a terminal in this specific node and run commands.
For example, you can monitor the evolution of the IP routing in a OSHI node, try a ping, etc...;

3-GUI) With Control-left-click on a node, you can open a shell on a given terminal in a new tab at the bottom of the web page

4) Now open two shell terminals on the controller of the topology, either using the mininet CLI
   - xterm ctr8 ctr8 
   or running ssh to the controller from two different shells on the host, you need to check the controller IP addressin the output of the script that has launched mininet) for example, assuming that the ip address is 10.255.248.1 
   - ssh -X root@10.255.248.1
   (the password is root)

in the first terminal start the RYU controller:
   - cd /home/user/workspace/dreamer-ryu/ryu/app
   - root@OSHI-VM:~/workspace/dreamer-ryu/ryu/app# ryu-manager rest_topology.py ofctl_rest.py --observe-links

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
### 4. Emulation example #2 - Deployment of Virtual Switches
##########################################################################################

- Emulation start:

1) Run the script deployer_example:
   - user@OSHI-VM:~/workspace/Dreamer-Mininet-Extensions$ sudo ./deployer_example.py

2) Wait for the end of the execution (you can see the Mininet CLI "mininet>").
At this step, the topology is started and properly configured.

3) Now open two xterm on the controller of the topology, in the first terminal start the RYU controller:
   - xterm ctr1 ctr1 
   - cd /home/user/workspace/dreamer-ryu/ryu/app
   - root@OSHI-VM:~/workspace/dreamer-ryu/ryu/app# ryu-manager rest_topology.py ofctl_rest.py --observe-links

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
### 5.  Segment routing examples
##########################################################################################

See "Small scale topology" (Segment Routing paths deployment in the emulator) example in https://github.com/netgroup/SDN-TE-SR-tools


##########################################################################################

Tutorial to run experimental topologies of OSHI network in the OFELIA/GOFF testbeds:
http://netgroup.uniroma2.it/twiki/pub/Oshi/WebHome/ofelia-experiment.pdf
