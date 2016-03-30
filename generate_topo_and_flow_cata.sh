#!/bin/bash

echo "#########################################################"
echo "##     OSHI Hybrid IP/SDN Hybrid                       ##"
echo "##                                                     ##"
echo "##     generate_topo_and_flow_cata.sh                  ##"
echo "##                                                     ##"
echo "##  usage:                                             ##"
echo "## ./generate_topo_and_flow_cata.sh controller_ip:port ##"
echo "##                                                     ##"
echo "##  example:                                           ##"
echo "## ./generate_topo_and_flow_cata.sh 10.255.245.1:8080  ##"
echo "#########################################################"

WORKSPACE="workspace"
cd /home/user/$WORKSPACE/sdn-te-sr-tools/parsers-generators
python parse_transform_generate.py --in ctrl_ryu --out nx --generate_flow_cata_from_vll_pusher_cfg --controller $1 
mv flow_catalogue.json ../java-te-sr/flow/
mv links.json ../java-te-sr/topology/
mv nodes.json ../java-te-sr/topology/