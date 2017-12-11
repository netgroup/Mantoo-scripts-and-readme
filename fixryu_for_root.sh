#!/bin/bash

NETWORKX_VERSION="1.11"

sudo -H pip install webob
sudo -H pip install routes
sudo -H pip install paramiko
sudo -H pip install 'oslo.config<2.0.0'
sudo -H pip install msgpack-python
sudo -H pip install lxml
sudo -H pip install 'eventlet==0.20'

sudo -H pip install ipaddress
# Networkx
sudo -H pip install networkx==$NETWORKX_VERSION
# netaddr (tool for subnetting)
sudo -H pip install netaddr