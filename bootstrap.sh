#!//usr/bin/env bash

#apt-get update
#apt-get install -y apache2
#rm -rf /var/www
#ln -fs /vagrant /var/www

cd /vagrant
curl -L https://www.opscode.com/chef/install.sh | bash
chef-solo -v
