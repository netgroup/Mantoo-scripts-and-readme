#!/bin/bash

MYUSER="user"
HOME_DIR="/home/$MYUSER"
WORKSPACE_DIR="$HOME_DIR/workspace"
MININET_DIR="$HOME_DIR/mininet"

IP_ROUTE2_VERSION="iproute2-4.14.1"

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
echo -e "\n-Installing curl"
sudo apt-get install -y curl &&

echo -e "\n\n#####################################"
echo -e "\n-Installing libappindicator1"
#needed for chrome
sudo apt-get install -y libappindicator1 &&

echo -e "\n\n#####################################"
echo -e "\n-Installing chrome"

rm /tmp/google-chrome-stable_current_amd64.deb

echo -e "downloading google chrome latest stable edition"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb
sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb

rm /tmp/google-chrome-stable_current_amd64.deb


echo -e "\n\n#####################################"
echo -e "\n-Installing node.js"
# Adding the NodeSource APT repository for Debian-based distributions repository
# AND the PGP key for verifying packages
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
# Install Node.js from the Debian-based distributions repository
sudo apt-get install -y nodejs &&
# get the most up-to-date npm
sudo npm install npm --global &&

echo -e "\n\n#####################################"
echo -e "\n-Installing shellinabox"
sudo apt-get install -y shellinabox


echo -e "\n\n#####################################"
echo -e "\n-Installing VLAN packages"
sudo apt-get install -y vlan &&

echo -e "\n\n#####################################"
echo -e "\n-Installing Quagga router services"
sudo apt-get install -y gawk
sudo apt-get install -y texinfo

#sudo apt-get install -y quagga
sudo apt-get install -y libreadline6 
sudo apt-get install -y libreadline6-dev
sudo apt-get install -y libc-ares-dev

cd $HOME_DIR
wget http://download.savannah.gnu.org/releases/quagga/quagga-1.1.1.tar.gz
tar xfz quagga-1.1.1.tar.gz
cd quagga-1.1.1

sudo groupadd quagga
sudo useradd -g quagga -s /bin/false quagga
sudo mkdir /etc/quagga
sudo mkdir -p /var/run/quagga
sudo mkdir -p /var/log/quagga

sudo chown quagga:quagga /etc/quagga
sudo chown quagga:quagga /var/run/quagga
sudo chown quagga:quagga /var/log/quagga

# Run configure
#./configure --enable-user=quagga --enable-group=quagga --enable-vty-group=quagga --enable-fpm --sysconfdir=/etc/quagga --localstatedir=/var/run/quagga --libdir=/usr/lib/quagga/
./configure --enable-user=quagga --enable-group=quagga --enable-vty-group=quagga --enable-fpm --prefix=/usr --sysconfdir=/etc/quagga --localstatedir=/var/run/quagga

make
sudo make install
sudo ldconfig

sudo cp  /etc/quagga/zebra.conf.sample /etc/quagga/zebra.conf
sudo cp  /etc/quagga/ospfd.conf.sample /etc/quagga/ospfd.conf
sudo chmod 640 -R /etc/quagga
sudo chmod 740 /etc/quagga
sudo chown quagga:quagga -R /etc/quagga

echo -e "\n\n#####################################"
echo -e "-VLAN module setup"
sudo modprobe 8021q &&
# Make 801q module loading permanent
if [ $(sudo cat /etc/modules | grep 8021q | wc -l) -eq 0 ]
	then
		#echo "8021q" >> /etc/modules
        echo "8021q" | sudo tee -a /etc/modules > /dev/null
fi


#echo -e "\n-Installing iproute"
#apt-get install -y iproute

echo -e "\n\n#####################################"
echo -e "\n-Installing sudo"
sudo apt-get install -y sudo

echo -e "\n\n#####################################"
echo -e "\n-Installing kdesudo"
sudo apt-get install -y kdesudo


echo -e "\n\n#####################################"
echo -e "\n-Upgrading iproute2"
# Install IPRoute2
wget https://git.kernel.org/pub/scm/linux/kernel/git/shemminger/iproute2.git/snapshot/$IP_ROUTE2_VERSION.tar.gz
# Extract the content
tar -xzvf $IP_ROUTE2_VERSION.tar.gz
# Enter in the source folder
cd $IP_ROUTE2_VERSION
# Compile everything
make
# Install new iproute2
sudo make install
echo -e "\nip -V (version):"
ip -V

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
sudo apt autoremove -y


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
		#echo "openvswitch" >> /etc/modules
        echo "openvswitch" | sudo tee -a /etc/modules > /dev/null
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
echo -e '#!/bin/bash
#
# start/stop openvswitch
### BEGIN INIT INFO
# Provides: openvswitchd
# Required-Start: $remote_fs $syslog
# Required-Stop: $remote_fs $syslog
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: OpenVSwitch daemon
# chkconfig: 2345 9 99
# Description: Activates/Deactivates all Open vSwitch to start at boot time.
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
exit 0' | sudo tee -a /etc/init.d/openvswitchd > /dev/null  &&
sudo chmod +x /etc/init.d/openvswitchd &&
sudo update-rc.d openvswitchd defaults 


mkdir $WORKSPACE_DIR
cd $WORKSPACE_DIR

git clone https://github.com/netgroup/Mantoo-scripts-and-readme.git
cd Mantoo-scripts-and-readme
./update_all_body.sh clone_repos

echo -e "\n\n#####################################"
echo -e "\n-Setting up admin password for RDCL 3D"

cd $WORKSPACE_DIR
cd RDCL3D/code
source env/bin/activate
python manage.py shell -c "from sf_user.models import CustomUser; CustomUser.objects.create_superuser('admin', 'admin')"
deactivate


echo -e "\n\n#####################################"
echo -e "\n-Setting up Desktop"

#sudo cp $WORKSPACE_DIR/Mantoo-scripts-and-readme/xubuntu-quantal-oshi-ok.png /usr/share/xfce4/backdrops
sudo cp $WORKSPACE_DIR/Mantoo-scripts-and-readme/xubuntu-quantal-oshi-rdcl3d.png /usr/share/xfce4/backdrops
cp $WORKSPACE_DIR/Mantoo-scripts-and-readme/VM-Desktop/xfce4-desktop.xml $HOME_DIR/.config/xfce4/xfconf/xfce-perchannel-xml/


ln -s $WORKSPACE_DIR/Mantoo-scripts-and-readme/OSHI-VM-README.txt $HOME_DIR/Desktop/README.txt
cp $WORKSPACE_DIR/Mantoo-scripts-and-readme/VM-Desktop/go.desktop $HOME_DIR/Desktop/
cp $WORKSPACE_DIR/Mantoo-scripts-and-readme/VM-Desktop/stop.desktop $HOME_DIR/Desktop/
cp $WORKSPACE_DIR/Mantoo-scripts-and-readme/VM-Desktop/update.desktop $HOME_DIR/Desktop/
cp $WORKSPACE_DIR/Mantoo-scripts-and-readme/VM-Desktop/check-status.desktop $HOME_DIR/Desktop/
cp $WORKSPACE_DIR/Mantoo-scripts-and-readme/VM-Desktop/OSHI_VM_9 $HOME_DIR/Desktop/
cp $WORKSPACE_DIR/Mantoo-scripts-and-readme/VM-Desktop/wireshark.desktop $HOME_DIR/Desktop/




# Change password for root
#echo 'root:12345' | chpasswd
# Enabling root login
#sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
#sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

