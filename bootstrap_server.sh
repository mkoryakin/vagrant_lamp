#!//usr/bin/env bash

#apt-get update
#apt-get install -y apache2
#rm -rf /var/www
#ln -fs /vagrant /var/www

cd /vagrant
rm -f chef-*.deb
apt-get update
apt-get install -y curl git vim
wget https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chef-server_11.0.4-1.ubuntu.12.04_amd64.deb
dpkg -i chef-*.deb
chef-server-ctl reconfigure
chef-server-ctl test
curl -L https://www.opscode.com/chef/install.sh | bash
chef-solo -v
