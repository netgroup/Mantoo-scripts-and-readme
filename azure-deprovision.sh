#!/bin/bash

cd /home
sudo mv $USER user-folder
sudo waagent -deprovision+user
