#!/bin/bash

echo "Current user: $USER"

cd /home
sudo chown --from=1000:1000 -R $USER:$USER user-folder
sudo mv user-folder $USER
sudo ln -s /home/$USER /home/user
sudo chown -h $USER:$USER /home/user
