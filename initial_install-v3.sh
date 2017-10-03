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

echo -e "\n\n#####################################"
echo -e "\n-Installing tcpdump"
# Install tcpdump
sudo apt-get install -y tcpdump

echo -e "\n\n#####################################"
echo -e "\n-Installing iproute"
# Install iproute
sudo apt-get install -y iproute

echo -e "\n\n#####################################"
echo -e "\n-Installing python-pip"
# Install python-pip
sudo apt-get install -y python-pip


echo -e "\n\n#####################################"
echo -e "\n-Installing virtualenv"
# Install virtualenv
sudo apt-get install -y virtualenv

echo -e "\n\n#####################################"
echo -e "\n-Installing sshpass"
# Install ssh-pass
sudo apt-get install -y sshpass

echo -e "\n\n#####################################"
echo -e "\n-Installing wondershaper"
# Install wondershaper
sudo apt-get install -y wondershaper

echo -e "\n\n#####################################"
echo -e "\n-Installing git-core"
# Install git-core
sudo apt-get install -y git-core

echo -e "\n\n#####################################"
echo -e "\n-Installing net-tools"
# Install net-tools
sudo apt-get install -y net-tools


echo -e "\n\n#####################################"
echo -e "\n-Installing bison"
# Install bison
sudo apt-get install -y bison


echo -e "\n\n#####################################"
echo -e "\n-Installing flex"
# Install flex
sudo apt-get install -y flex

echo -e "\n\n#####################################"
echo -e "\n-Installing traceroute"
# Install traceroute
sudo apt-get install -y traceroute

# Install sublime evaluation version
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install -y sublime-text

#################################
#adding packages from Mantoo/OSHI

echo -e "\n\n#####################################"
echo -e "\n-Installing vim"
sudo apt-get install -y vim &&

echo -e "\n\n#####################################"
echo -e "\n-Installing python-simplejson"
sudo apt-get install -y python-simplejson &&

echo -e "\n\n#####################################"
echo -e "\n-Installing Python-QT4"
sudo apt-get install -y python-qt4 &&

echo -e "\n\n#####################################"
echo -e "\n-Installing Python Zope Interface"
sudo apt-get install -y python-zopeinterface &&

echo -e "\n\n#####################################"
echo -e "\n-Installing Python-Twisted-Conch"
sudo apt-get install -y python-twisted-conch &&

echo -e "\n\n#####################################"
echo -e "\n-Installing pkg-config"
sudo apt-get install -y pkg-config &&

echo -e "\n\n#####################################"
echo -e "\n-Installing dh-autoreconf"
sudo apt-get install -y dh-autoreconf &&

echo -e "\n\n#####################################"
echo -e "\n-Installing ipcalc"
sudo apt-get install -y ipcalc &&

echo -e "\n\n#####################################"
echo -e "\n-Installing Linux Headers for Linux kernel `uname -r`"
sudo apt-get install -y linux-headers-`uname -r` &&

echo -e "\n\n#####################################"
echo -e "\n-Installing OpenVPN"
sudo apt-get install -y openvpn &&

echo -e "\n\n#####################################"
echo -e "\n-Installing VLAN packages"
sudo apt-get install -y vlan &&

echo -e "\n\n#####################################"
echo -e "\n-Installing Quagga router services"
sudo apt-get install -y gawk
sudo apt-get install -y texinfo

#sudo apt-get install -y quagga
wget https://launchpad.net/~ubuntu-security-proposed/+archive/ubuntu/ppa/+build/11037964/+files/quagga_0.99.24.1-2ubuntu1.2_amd64.deb
sudo apt-get install libreadline6
sudo dpkg -i quagga_0.99.24.1-2ubuntu1.2_amd64.deb

sudo touch /etc/quagga/zebra.conf
sudo touch /etc/quagga/ospfd.conf

echo -e "\n\n#####################################"
echo -e "\n-Upgrading Quagga router services"

# Download quagga with the support for fpm
wget http://download.savannah.gnu.org/releases/quagga/quagga-0.99.24.1.tar.gz -O /home/user/quagga.tar.gz
cd /home/user

tar -xzvf quagga.tar.gz
cd quagga-0.99.24.1/

# Run configure
./configure --enable-user=quagga --enable-group=quagga --enable-vty-group=quagga --enable-fpm --sysconfdir=/etc/quagga --localstatedir=/var/run/quagga --libdir=/usr/lib/quagga/
make
sudo make install
sudo ldconfig

# Generate commands and substitute old commands with new ones
cd zebra/
sudo ./zebra &
sleep 1
sudo killall lt-zebra 2> /dev/null
sudo killall zebra 2> /dev/null
cd .libs/
sudo cp zebra /usr/lib/quagga/zebra
cd ../../
cd ospfd/
sudo ./ospfd &
sleep 1
sudo killall lt-ospfd 2> /dev/null
sudo killall ospfd 2> /dev/null
cd .libs/
sudo cp ospfd /usr/lib/quagga/ospfd


echo -e "\n\n#####################################"
echo -e "-VLAN module setup"
sudo modprobe 8021q &&
# Make 801q module loading permanent
if [ $(sudo cat /etc/modules | grep 8021q | wc -l) -eq 0 ]
	then
		sudo echo "8021q" >> /etc/modules
fi


#echo -e "\n-Installing iproute"
#apt-get install -y iproute

echo -e "\n\n#####################################"
echo -e "\n-Installing sudo"
sudo apt-get install -y sudo

##########################################

echo -e "\n\n#####################################"
echo -e "\n-Upgrading iproute2"
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


echo -e "\n\n#####################################"
echo -e "\n-Installing mininet"
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
# netaddr (tool for subnetting)
pip install netaddr

echo -e "\n\n#####################################"
echo -e "\n-Re-installing OpenVSwitch from sources"

sudo /etc/init.d/openvswitch-switch stop
sudo /etc/init.d/openvswitch-testcontroller stop
sudo apt-get remove -y openvswitch-switch
sudo apt-get remove -y openvswitch-testcontroller


# Creating folder for OVS under /opt/ovs
sudo rm -f -r /opt/ovs 2> /dev/null
sudo mkdir -p /opt/ovs
# Remove previous kernel module
sudo modprobe -r openvswitch 2> /dev/null
sudo mv /lib/modules/`uname -r`/kernel/openvswitch/openvswitch.ko /lib/modules/`uname -r`/kernel/openvswitch/openvswitch.ko.orig 2> /dev/null
# Downloading
cd /opt/ 
sudo git clone https://github.com/openvswitch/ovs.git
cd  /opt/ovs/ 
# Boot up and configuring sources
sudo ./boot.sh &&
sudo ./configure --with-linux=/lib/modules/`uname -r`/build &&
# Make
sudo make &&
sudo make install &&
# OVS module installation
sudo make modules_install &&
sudo mkdir -p /lib/modules/`uname -r`/kernel/openvswitch
sudo cp /opt/ovs/datapath/linux/openvswitch.ko /lib/modules/`uname -r`/kernel/openvswitch/openvswitch.ko
sudo depmod -a &&
# Making module loading permanent
sudo modprobe openvswitch &&
if [ $(cat /etc/modules | grep openvswitch | wc -l) -eq 0 ]
	then
		sudo echo "openvswitch" >> /etc/modules
fi
# Create and initialize the database
sudo rm -f -r /usr/local/etc/openvswitch/ 2> /dev/null
sudo mkdir -p /usr/local/etc/openvswitch &&
sudo rm -f -r /usr/local/var/run/openvswitch/ 2> /dev/null
sudo mkdir -p /usr/local/var/run/openvswitch &&
sudo ovsdb-tool create /usr/local/etc/openvswitch/conf.db /opt/ovs/vswitchd/vswitch.ovsschema &&
sudo ovsdb-server --remote=punix:/usr/local/var/run/openvswitch/db.sock \
                     --remote=db:Open_vSwitch,Open_vSwitch,manager_options \
                     --private-key=db:Open_vSwitch,SSL,private_key \
                     --certificate=db:Open_vSwitch,SSL,certificate \
                     --bootstrap-ca-cert=db:Open_vSwitch,SSL,ca_cert \
                     --pidfile --detach
sudo ovs-vsctl --no-wait init &&

# Starting OVS
echo -e "\n\n#####################################"
echo -e "\n-Starting OpenVSwitch"
sudo ovs-vswitchd --pidfile --detach &&
# Adding OVS as a service


echo -e "\n\n#####################################"
echo -e "\n-Adding OpenVSwitch service"
sudo echo -e '#!/bin/bash
#
# start/stop openvswitch
### BEGIN INIT INFO
# Provides: openvswitchd
# Required-start: $remote_fs $syslog
# Required-stop: $remote_fs $syslog
# Default-start: 2 3 4 5
# Default-stop: 0 1 6
# Short-description: OpenVSwitch daemon
# chkconfig: 2345 9 99
# description: Activates/Deactivates all Open vSwitch to start at boot time.
# processname: openvswitchd
# config: /usr/local/etc/openvswitch/conf.db
# pidfile: /usr/local/var/run/openvswitch/ovs-vswitchd.pid
### END INIT INFO\n

PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin
export PATH\n

# Source function library. . /etc/rc.d/init.d/functions
. /lib/lsb/init-functions\n

stop()
{
echo "
Stopping openvswitch..."\n

if [ -e /usr/local/var/run/openvswitch/ovs-vswitchd.pid ]; then
pid=$(cat /usr/local/var/run/openvswitch/ovs-vswitchd.pid)
/usr/local/bin/ovs-appctl -t /usr/local/var/run/openvswitch/ovs-vswitchd.$pid.ctl exit
rm -f /usr/local/var/run/openvswitch/ovs-vswitchd.$pid.ctl
fi\n

if [ -e /usr/local/var/run/openvswitch/ovsdb-server.pid ]; then
pid=$(cat /usr/local/var/run/openvswitch/ovsdb-server.pid)
/usr/local/bin/ovs-appctl -t /usr/local/var/run/openvswitch/ovsdb-server.$pid.ctl exit
rm -f /usr/local/var/run/openvswitch/ovsdb-server.$pid.ctl
fi\n

rm -f /var/lock/subsys/openvswitchd
echo "OK"
}\n

start()
{
echo "
Starting openvswitch..."
/usr/local/sbin/ovsdb-server /usr/local/etc/openvswitch/conf.db \
--remote=punix:/usr/local/var/run/openvswitch/db.sock \
--remote=db:Open_vSwitch,Open_vSwitch,manager_options \
--private-key=db:Open_vSwitch,SSL,private_key \
--certificate=db:Open_vSwitch,SSL,certificate \
--bootstrap-ca-cert=db:Open_vSwitch,SSL,ca_cert \
--pidfile --detach\n

/usr/local/bin/ovs-vsctl --no-wait init
/usr/local/sbin/ovs-vswitchd unix:/usr/local/var/run/openvswitch/db.sock --pidfile --detach\n

mkdir -p /var/lock/subsys
touch /var/lock/subsys/openvswitchd
echo "
OpenVSwitch started succesfully!"
}\n

# See how we were called.
case $1 in
start)
start
;;
stop)
stop
;;
restart)
stop
start
;;
status)
status ovs-vswitchd
;;
*)
echo "Usage: openvswitchd {start|stop|status|restart}."
exit 1
;;
esac\n
exit 0' > /etc/init.d/openvswitchd &&
sudo chmod +x /etc/init.d/openvswitchd &&
sudo update-rc.d openvswitchd defaults 


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

