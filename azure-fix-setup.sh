#!/bin/bash

echo "Current user: $USER"

VARI=$(ls -l /home | grep user-folder | awk '{print $3}')

echo "Owner of /home/user-folder: $VARI"

if [ "$USER" == "user" ]
then
   echo "The current user cannot be user"
   echo "EXITING WITH NO ACTION"
   return
fi
 

cd /home
sudo chown --from=$VARI:$VARI -R $USER:$USER user-folder
sudo rm  -rf /home/$USER
sudo mv /home/user-folder /home/$USER
sudo rm /home/user
sudo ln -s /home/$USER /home/user
sudo chown -h $USER:$USER /home/user
