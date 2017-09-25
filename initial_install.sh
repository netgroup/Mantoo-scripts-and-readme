#!/bin/bash

MYUSER="user"
HOME_DIR="/home/$MYUSER"
WORKSPACE_DIR="$HOME_DIR/workspace"
MININET_DIR="$HOME_DIR/mininet"

# Debug banner
echo -e "\n"
echo "#############################################################"
echo "##                OSHI VM Setup Tools                      ##"
echo "##                                                         ##"
echo "##       The process can last many minutes. Please         ##"
echo "##       do not interrupt the process.                     ##"
echo "#############################################################"
echo -e "\n"

# disable apt-daily.service if it is running
sudo systemctl stop apt-daily.service
sudo systemctl kill --kill-who=all apt-daily.service
# wait until `apt-get updated` has been killed
while ! (systemctl list-units --all apt-daily.service | fgrep -q dead)
do
  sleep 1;
done


# Update apt
sudo apt-get update
# Install openssh dependency
sudo apt-get install -y openssh-server
# Install tcpdump
sudo apt-get install -y tcpdump
# Install iproute
sudo apt-get install -y iproute
# Install python-pip
sudo apt-get install -y python-pip
# Install virtualenv
sudo apt-get install -y virtualenv
# Install ssh-pass
sudo apt-get install -y sshpass
# Install wondershaper
sudo apt-get install -y wondershaper
# Install git-core
sudo apt-get install -y git-core
# Install net-tools
sudo apt-get install -y net-tools
# Install bison
sudo apt-get install -y bison
# Install flex
sudo apt-get install -y flex
# Install traceroute
sudo apt-get install -y traceroute

# Install sublime evaluation version
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install -y sublime-text


# Install IPRoute2
wget https://git.kernel.org/pub/scm/linux/kernel/git/shemminger/iproute2.git/snapshot/iproute2-4.13.0.tar.gz
# Extract the content
tar -xzvf iproute2-4.13.0.tar.gz
# Enter in the source folder
cd iproute2-4.13.0
# Compile everything
make
# Install new iproute2
sudo make install


mkdir $MININET_DIR
#chown $MYUSER:$MYUSER $MININET_DIR
cd $MININET_DIR

# Install Mininet
git clone git://github.com/mininet/mininet
# Run "ALL" setup

mininet/util/install.sh -a

#virtualenv env
#source env/bin/activate

# Python dependencies
pip install ipaddress
# Networkx
pip install networkx==1.11

#deactivate

mkdir $WORKSPACE_DIR
cd $WORKSPACE_DIR

git clone https://github.com/netgroup/Mantoo-scripts-and-readme.git
cd Mantoo-scripts-and-readme
./update_all_body.sh clone_repos



# Change password for root
#echo 'root:12345' | chpasswd
# Enabling root login
#sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
#sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

