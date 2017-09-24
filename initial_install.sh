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
systemctl stop apt-daily.service
systemctl kill --kill-who=all apt-daily.service
# wait until `apt-get updated` has been killed
while ! (systemctl list-units --all apt-daily.service | fgrep -q dead)
do
  sleep 1;
done


# Update apt
apt-get update
# Install openssh dependency
apt-get install -y openssh-server
# Install tcpdump
apt-get install -y tcpdump
# Install iproute
apt-get install -y iproute
# Install python-pip
apt-get install -y python-pip
# Install virtualenv
apt-get install -y virtualenv
# Install ssh-pass
apt-get install -y sshpass
# Install wondershaper
apt-get install -y wondershaper
# Install git-core
apt-get install -y git-core
# Install net-tools
apt-get install -y net-tools
# Install bison
apt-get install -y bison
# Install flex
apt-get install -y flex
# Install traceroute
apt-get install -y traceroute

# Install sublime evaluation version
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
apt-get update
apt-get install -y sublime-text


# Install IPRoute2
wget https://git.kernel.org/pub/scm/linux/kernel/git/shemminger/iproute2.git/snapshot/iproute2-4.13.0.tar.gz
# Extract the content
tar -xzvf iproute2-4.13.0.tar.gz
# Enter in the source folder
cd iproute2-4.13.0
# Compile everything
make
# Install new iproute2
make install


mkdir $MININET_DIR
chown $MYUSER:$MYUSER $MININET_DIR
cd $MININET_DIR

# Install Mininet (as root)
git clone git://github.com/mininet/mininet
# Run "ALL" setup
mininet/util/install.sh -a

cd mininet
virtualenv --system-site-packages env
source env/bin/activate

# Python dependencies
pip install ipaddress
# Networkx
pip install networkx

deactivate

sudo -u $MYUSER mkdir $WORKSPACE_DIR
cd $WORKSPACE_DIR

sudo -u $MYUSER git clone https://github.com/netgroup/Mantoo-scripts-and-readme.git
cd Mantoo-scripts-and-readme
sudo -u $MYUSER ./update_all_body.sh clone_repos



# Change password for root
#echo 'root:12345' | chpasswd
# Enabling root login
#sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
#sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

