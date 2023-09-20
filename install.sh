# create custom keypair for this lab
ssh-keygen -t rsa -b 4096 -f ~/Documents/test/vagrant/ubuntu2204/keys/private

# Install plugin to write down name vm and ip address to /etc/hosts
vagrant plugin install vagrant-hostsupdater

# Install the couchbase server
#1, download the metapackage
curl -O https://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-amd64.deb
#2, Install the meta package
sudo dpkg -i ./couchbase-release-1.0-amd64.deb
#3, reload the local package database
sudo apt-get update
#4, Install couchbase server
#list available releases
apt list -a couchbase-server-community
#install couchbase server with version, and nescessary packages
sudo apt install couchbase-server-community=7.2.1-5934-1
sudo apt install jq -y
# system time and data in systemd system
timedatectl
# install the ntp server for clock synchonization between couchbase database
# sudo apt-get install ntp -y
# sudo apt-get install ntpstat -y
# install systemd-timesyncd for lightweight and easy use
apt install systemd-timesyncd -y
# change ntp sync on server
sudo timedatectl set-ntp true
# Enable ntpd linux
sudo systemctl enable ntp
#check enabled service
systemctl is-enabled systemd-timesyncd
# Allow firewill if need
sudo ufw allow 123/udp 
#add a directory to the PATH environment
echo "export PATH=/opt/couchbase/bin:$PATH" >> ~/.bashrc
source ~/.bashrc 