#!/bin/bash

echo "##########################################################"
echo "##     OSHI Hybrid IP/SDN Hybrid                        ##"
echo "##                                                      ##"
echo "##     sr_pusher_start.sh                               ##"
echo "##                                                      ##"
echo "##  usage:                                              ##"
echo "## ./sr_pusher_start.sh controller_ip:port --add/--del  ##"
echo "##                                                      ##"
echo "##  example:                                            ##"
echo "## ./sr_pusher_start.sh 10.255.245.1:8080 --add         ##"
echo "##########################################################"

WORKSPACE="workspace"
cd /home/user/$WORKSPACE/sdn-te-sr-tools
mv java-te-sr/flow/flow_catalogue.json.out OSHI-SR-pusher/out_flow_catalogue.json
cd /home/user/$WORKSPACE/sdn-te-sr-tools/OSHI-SR-pusher/
rm sr_vlls.json
./sr_vll_pusher.py --controller $1 $2